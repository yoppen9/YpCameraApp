//
//  EffectViewController.swift
//  YpCameraApp
//
//  Created by 山岸善将 on 2021/06/24.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        effectImage.image = originalImage
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    var originalImage : UIImage?
    
    
    @IBOutlet weak var effectImage: UIImageView!
    
    let filterArray = ["CIPhotoEffectMono","CIPhotoEffectChrome","CIPhotoEffectFade","CIPhotoEffectInstant","CIPhotoEffectNoir","CIPhotoEffectProcess","CIPhotoEffectTonal","CIPhotoEffectTransfer","CISpiaTone"]
    
    var filterSelectNumber = 0
    
    @IBAction func effectButtonAction(_ sender: Any) {
        
        if let image = originalImage {
            let filterName = filterArray[filterSelectNumber]
            filterSelectNumber += 1
            if filterSelectNumber == filterArray.count {
                filterSelectNumber = 0
            }
            let rotate = image.imageOrientation
            let inputImage = CIImage(image: image)
            guard let effecrFilter = CIFilter(name: filterName) else {
                return
            }
            
            effecrFilter.setDefaults()
            effecrFilter.setValue(inputImage, forKey: kCIInputImageKey)
            guard let outputImage = effecrFilter.outputImage else {
                return
            }
            let ciContext = CIContext(options: nil)
            guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                return
            }
            effectImage.image = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
        }
        
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        if let shareImage = effectImage.image {
            let shareItems = [shareImage]
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            controller.popoverPresentationController?.sourceView = view
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
