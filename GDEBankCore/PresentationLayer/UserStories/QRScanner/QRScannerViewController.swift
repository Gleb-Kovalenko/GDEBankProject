import UIKit
import Layout
import GDEBankCore
import Foundation
import AVFoundation
import ComposableArchitecture

// MARK: - QRScannerViewController

public final class QRScannerViewController: TCAViewController<QRScanner> {

    // MARK: - Properties

    /// The capture session that manages QR code scanning
    private let captureSession: AVCaptureSession

    /// The layer that displays the video stream on the screen
    private let previewLayer: AVCaptureVideoPreviewLayer

    /// The view used for overlaying elements on top of the camera feed
    private var camOverlayImageView = UIView()

    /// The background view with a semi-transparent overlay
    private let backgroundView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }

    /// The title label displayed on the screen
    private let titleLabel = UILabel().then { label in
        label.textColor = UIColor.white
        label.font = .inter(size: 18, weight: .regular)
        label.text = L10n.QrCode.title
    }

    /// The instruction label providing guidance to the user
    private let instructionLabel = UILabel().then { label in
        label.textColor = UIColor.white
        label.font = .inter(size: 12, weight: .regular)
        label.text = L10n.QrCode.instruction
    }

    /// The label displaying scanning status
    private let statusLabel = UILabel().then { label in
        label.lineBreakMode = .byWordWrapping
        label.font = .inter(size: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 3
    }

    /// Flash button
    private let flashButton = UIButton().then { button in
        button.setImage(CoreAssets.lightningSlash.image, for: .normal)
        button.tintColor = CoreColors.gray1.color
        button.backgroundColor = CoreColors.gray6.color
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left: 11, bottom: 9, right: 11)
    }

    /// Gallery button
    private let galleryButton = UIButton().then { button in
        button.setImage(CoreAssets.image.image, for: .normal)
        button.tintColor = CoreColors.gray1.color
        button.backgroundColor = CoreColors.gray6.color
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 9, bottom: 10, right: 9)
    }

    // MARK: - Initializers

    public override init(store: StoreOf<QRScanner>) {
        captureSession = AVCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        super.init(store: store)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.setupCaptureDevice()
        }
        flashButton.add(event: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.toggleFlash()
        }
        galleryButton.add(event: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.openGallery()
        }
        setupObserves()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.global(qos: .userInitiated).async {
            if self.captureSession.isRunning {
                self.captureSession.stopRunning()
            }
        }
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let maskLayer = CAShapeLayer()
        maskLayer.frame = backgroundView.bounds
        maskLayer.fillColor = UIColor.black.cgColor

        let path = UIBezierPath(rect: backgroundView.bounds)
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        path.append(UIBezierPath(roundedRect: camOverlayImageView.frame, cornerRadius: 26))
        maskLayer.path = path.cgPath

        backgroundView.layer.mask = maskLayer
    }
    
    // MARK: - Observers
    
    private func setupObserves() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setupCaptureDevice),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    // MARK: - CaptureDeviceSetup

    @objc private func setupCaptureDevice() {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authorizationStatus {
        case .authorized:
            configureCaptureSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if granted {
                        self.configureCaptureSession()
                    } else {
                        self.showCameraAccessDeniedAlert()
                    }
                }
            }
        case .denied, .restricted:
            showCameraAccessDeniedAlert()
        @unknown default:
            return
        }
    }

    private func configureCaptureSession() {
        do {
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                throw NSError.new(message: L10n.QrScanning.Error.noVideoDevice)
            }
            
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                throw NSError.new(message: L10n.QrScanning.Error.addVideoInput)
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            if captureSession.canAddOutput(metadataOutput) {
                captureSession.addOutput(metadataOutput)
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr]
            } else {
                throw NSError.new(message: L10n.QrScanning.Error.addMetadataOutput)
            }
            
            previewLayer.videoGravity = .resizeAspectFill
            DispatchQueue.main.async {
                self.view.layer.insertSublayer(self.previewLayer, at: 0)
                self.previewLayer.frame = self.view.frame
            }
        } catch {
            self.showAlert(message: error.localizedDescription)
        }
    }

    // MARK: - Layout

    public override func layout() {
        setupCamOverlayImageView()
        setupBackgroundView()
        setupInstructionLabel()
        setupCameraPreviewBorder()
        setupTitleLabel()
        setupButtonsStack()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel.prepareForAutolayout())
        titleLabel
            .top(to: safeTop)
            .centerX(to: view.centerX)
        let closeButton = UIButton()
        closeButton.setImage(GDEBankCore.Assets.closeSmall.image, for: .normal)
        closeButton.add(event: .touchUpInside) { [weak self] in
            guard let self else { return }
            self.store.send(.closeButtonTapped)
        }
        view.addSubview(closeButton.prepareForAutolayout())
        closeButton
            .centerY(to: titleLabel.centerY)
            .right(to: view.right - 16)
            .size(24)
        closeButton.left.greater(than: titleLabel.right, withInset: 8)
    }

    private func setupBackgroundView() {
        view.addSubview(backgroundView.prepareForAutolayout())
        backgroundView.pinToSuperview()
    }

    private func setupCamOverlayImageView() {
        view.addSubview(camOverlayImageView.prepareForAutolayout())
        camOverlayImageView
            .center(in: view)
            .size(UIScreen.screenWidth * 0.728)
    }

    private func setupInstructionLabel() {
        view.addSubview(instructionLabel.prepareForAutolayout())
        instructionLabel
            .top(to: camOverlayImageView.bottom + 24)
            .centerX(to: view.centerX)
        instructionLabel.left.greater(than: view.left, withInset: 40)
        instructionLabel.right.less(than: view.right, withInset: 40)
    }

    private func setupCameraPreviewBorder() {
        let vector1ImageView = UIImageView(image: Assets.qrCodeCorner.image)
        let vector2ImageView = UIImageView(image: Assets.qrCodeCorner.image).then {
            $0.transform = $0.transform.rotated(by: .pi / 2)
        }
        let vector3ImageView = UIImageView(image: Assets.qrCodeCorner.image).then {
            $0.transform = $0.transform.rotated(by: .pi)
        }
        let vector4ImageView = UIImageView(image: Assets.qrCodeCorner.image).then {
            $0.transform = $0.transform.rotated(by: .pi * 1.5)
        }
        view.addSubview(vector1ImageView.prepareForAutolayout())
        view.addSubview(vector2ImageView.prepareForAutolayout())
        view.addSubview(vector3ImageView.prepareForAutolayout())
        view.addSubview(vector4ImageView.prepareForAutolayout())
        NSLayoutConstraint.activate([
            vector1ImageView.leadingAnchor.constraint(equalTo: camOverlayImageView.leadingAnchor, constant: -2),
            vector1ImageView.topAnchor.constraint(equalTo: camOverlayImageView.topAnchor, constant: -2),
            vector2ImageView.topAnchor.constraint(equalTo: camOverlayImageView.topAnchor, constant: -2),
            vector2ImageView.trailingAnchor.constraint(equalTo: camOverlayImageView.trailingAnchor, constant: 2),
            vector3ImageView.bottomAnchor.constraint(equalTo: camOverlayImageView.bottomAnchor, constant: 2),
            vector3ImageView.trailingAnchor.constraint(equalTo: camOverlayImageView.trailingAnchor, constant: 2),
            vector4ImageView.bottomAnchor.constraint(equalTo: camOverlayImageView.bottomAnchor, constant: 2),
            vector4ImageView.leadingAnchor.constraint(equalTo: camOverlayImageView.leadingAnchor, constant: -2)
        ])
    }

    private func setupButtonsStack() {
        let buttonsStack = UIStackView(
            arrangedSubviews: [
                flashButton
                    .prepareForAutolayout()
                    .size(40),
                galleryButton
                    .prepareForAutolayout()
                    .size(40)
            ]
        )
        buttonsStack.axis = .horizontal
        buttonsStack.spacing = 32
        buttonsStack.alignment = .center
        view.addSubview(buttonsStack.prepareForAutolayout())
        buttonsStack
            .top(to: instructionLabel.bottom + 60)
            .centerX(to: view.centerX)
    }

    // MARK: - Actions

    private func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {
            showAlert(message: L10n.QrScanning.Error.torchUnavailable)
            return
        }
        do {
            try device.lockForConfiguration()
            device.torchMode = device.torchMode == .on ? .off : .on
            flashButton.setImage(
                device.torchMode == .on ? CoreAssets.lightning.image : CoreAssets.lightningSlash.image,
                for: .normal
            )
            device.unlockForConfiguration()
        } catch {
            showAlert(message: L10n.QrScanning.Error.toggleFlash)
        }
    }

    private func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    // MARK: - Alert

    private func showAlert(message: String) {
        let alert = UIAlertController(title: CoreLocalization.General.error, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showCameraAccessDeniedAlert() {
        let alert = UIAlertController(
            title: L10n.QrScanning.Error.cameraAccessDeniedTitle,
            message: L10n.QrScanning.Error.cameraAccessDeniedMessage,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: CoreLocalization.General.cancel, style: .cancel))
        alert.addAction(UIAlertAction(
            title: CoreLocalization.General.settings,
            style: .default,
            handler: { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        ))

        present(alert, animated: true)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {

    public override var prefersStatusBarHidden: Bool {
        true
    }

    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    public func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard let metadataObject = metadataObjects.first else {
            showAlert(message: L10n.QrScanning.Error.noQrCode)
            return
        }
        guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
            showAlert(message: L10n.QrScanning.Error.unableToProcessCode)
            return
        }
        guard let stringValue = readableObject.stringValue else {
            showAlert(message: L10n.QrScanning.Error.emptyQrCode)
            return
        }
        store.send(.qrCodeTriggerred(stringValue))
    }
}

// MARK: - UIImagePickerControllerDelegate

extension QRScannerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            showAlert(message: L10n.QrScanning.Error.failedImageSelection)
            return
        }
        extractQRCode(from: image)
    }

    private func extractQRCode(from image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            showAlert(message: L10n.QrScanning.Error.failedImageProcessing)
            return
        }
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        let features = detector?.features(in: ciImage) as? [CIQRCodeFeature]
        if let qrCode = features?.first?.messageString {
            store.send(.qrCodeTriggerred(qrCode))
        } else {
            showAlert(message: L10n.QrScanning.Error.noQrCodeInImage)
        }
    }
}
