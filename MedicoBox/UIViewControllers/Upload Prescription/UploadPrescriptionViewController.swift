//
//  UploadPrescriptionViewController.swift
//  MedicoBox
//
//  Created by SBC on 27/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit
import OpalImagePicker


class UploadPrescriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate {
    var searchBar :UISearchBar? 

   
    @IBOutlet weak var collectionViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var prescriptionCollectionView: UICollectionView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageTake: UIImageView!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var youOrderingView: UIView!
    var imagePicker: UIImagePickerController!
    var collectionImageArray = [UIImage]()
    var flagViewWillAppear = "";
    
    override func viewDidLoad() {
//        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        prescriptionCollectionView.dataSource = self
        prescriptionCollectionView.delegate = self
        
        //show navigationbar with back button
        searchBar = UISearchBar(frame: CGRect.zero);
        self.setNavigationBarItemBackButton(searchBar: searchBar!)
        self.searchBar?.delegate = self;
         self.navigationController?.isNavigationBarHidden = false;
        btnYes.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        btnNo.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        flagViewWillAppear = "true";

    }
    override func viewWillAppear(_ animated: Bool) {
        
         if(flagViewWillAppear == "true"){
            
            
            
            if(collectionImageArray.count == 0){
                
                self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant - 157;
                prescriptionCollectionView.isHidden = true;
                collectionViewHightConstraint.constant = 0;
                UIView.animate(withDuration: 0.5) {
                    self.view.updateConstraints()
                    self.view.layoutIfNeeded()
                }
            }
            flagViewWillAppear = "false";

         }else {
            

        }
       self.navigationController?.isNavigationBarHidden = false;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func continueBtnAction(_ sender: Any) {

        let Controller = kPrescriptionStoryBoard.instantiateViewController(withIdentifier: kUploadPresriptionSecondVC)
        
        self.navigationController?.pushViewController(Controller, animated: true)
    }
    
    //MARK:- Collection View Delegate And DataSource
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberCount:Int = Int()
        
        numberCount = collectionImageArray.count;
        return numberCount
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        let CommomCell:UICollectionViewCell = UICollectionViewCell()
        
        // get a reference to our storyboard cell
        let cellObj = collectionView.dequeueReusableCell(withReuseIdentifier: "PrescriptionCollectionViewCell", for: indexPath as IndexPath) as! PrescriptionCollectionViewCell
        cellObj.imageView.image = collectionImageArray[indexPath.item] as? UIImage;
        cellObj.btnCross.tag = indexPath.row;
        cellObj.btnCross.addTarget(self, action: #selector(btnDeleteAction(button:)), for: UIControlEvents.touchUpInside);
        return cellObj;
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {

            return CGSize(width: 112, height: 133)

    }
    
    @objc func btnDeleteAction(button: UIButton) {
        
        let position: CGPoint = button.convert(.zero, to: self.prescriptionCollectionView)
        let indexPath = self.prescriptionCollectionView.indexPathForItem(at: position)
        let cell:PrescriptionCollectionViewCell = self.prescriptionCollectionView.cellForItem(at: indexPath!) as! PrescriptionCollectionViewCell
        
        _ = SweetAlert().showAlert("Are you sure?", subTitle: "Are you sure to delete this file!", style: AlertStyle.warning, buttonTitle:"No", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Yes", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                _ = SweetAlert().showAlert("Cancelled!", subTitle: "Your file hase been cancelled", style: AlertStyle.error)
            }
            else {
                
                //Remove from index and array list
                var hitIndex: IndexPath? = self.prescriptionCollectionView.indexPathForItem(at: position)
                
                self.collectionImageArray.remove(at: (hitIndex?.item)!)
                self.prescriptionCollectionView.performBatchUpdates({
                    self.prescriptionCollectionView.deleteItems(at: [hitIndex!])
                }) { (finished) in
                    self.prescriptionCollectionView.reloadItems(at: self.prescriptionCollectionView.indexPathsForVisibleItems)
                }
                self.prescriptionCollectionView.reloadData()
                _ = SweetAlert().showAlert("Deleted!", subTitle: "Your file has been deleted!", style: AlertStyle.success)
                
                if(self.collectionImageArray.count == 0){
                    
                    self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant - 157;
                    self.prescriptionCollectionView.isHidden = true;
                    self.collectionViewHightConstraint.constant = 0;
                    UIView.animate(withDuration: 0.5) {
                        self.view.updateConstraints()
                        self.view.layoutIfNeeded()
                    }
                }else {
                    
                    
                    self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant + 157;
                    self.prescriptionCollectionView.isHidden = false;
                    self.collectionViewHightConstraint.constant = 157;
                    UIView.animate(withDuration: 0.5) {
                        self.view.updateConstraints()
                        self.view.layoutIfNeeded()
                    }
                    self.prescriptionCollectionView.reloadData()
                }
                
            }
        }
        
        
    }
    
    @IBAction func btnTakePhotoAction(_ sender: Any) {
        
       self.openCamera()
        
    }
    

    @IBAction func btnChooseFromGalleryAction(_ sender: Any) {
        
//        openGallery()
        //Example instantiating OpalImagePickerController with delegate
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.maximumSelectionsAllowed = 10
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func btnMyPrescriptionsAction(_ sender: Any) {
        
        
    }

    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
             let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            UIImageWriteToSavedPhotosAlbum(imageTake.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have perission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    //MARK:-- ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
            imageTake.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            collectionImageArray.append(imageTake!.image!)
            print(collectionImageArray)
            
            if(self.prescriptionCollectionView.isHidden){
                
                self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant + 157;
                self.prescriptionCollectionView.isHidden = false;
                self.collectionViewHightConstraint.constant = 157;
                UIView.animate(withDuration: 0.5) {
                    self.view.updateConstraints()
                    self.view.layoutIfNeeded()
                }
                self.prescriptionCollectionView.reloadData()

            }
//            }else {
//
//                self.mainViewHightConstraint.constant = -157;
//                prescriptionCollectionView.isHidden = true;
//                collectionViewHightConstraint.constant = 0;
//            }


        }
        
//        if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
//            let assetResources = PHAssetResource.assetResources(for: asset)
//
//            print(assetResources.first!.originalFilename)
//
//            imageArray.append(UIImage(named: assetResources.first!.originalFilename)!)
//
//        }
        self.prescriptionCollectionView.reloadData()
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnYesAction(_ sender: Any) {
      
            btnYes.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnNo.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        
            self.btnYes.isSelected = true;
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }

    }
    
    
    
    @IBAction func btnNoAction(_ sender: Any) {
        
            btnNo.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnYes.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        
            self.btnNo.isSelected = true
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        
    }
}

extension UploadPrescriptionViewController: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        //Save Images, update UI
        collectionImageArray.append(contentsOf: images)
//         if let jpegData = image.jpegData(compressionQuality: 0.8)
        
        //Dismiss Controller
        presentedViewController?.dismiss(animated: true, completion: nil)
        if(collectionImageArray.count != 0){
            if(self.prescriptionCollectionView.isHidden){
            self.mainViewHightConstraint.constant = self.mainViewHightConstraint.constant + 157;
            self.prescriptionCollectionView.isHidden = false;
            self.collectionViewHightConstraint.constant = 157;
            UIView.animate(withDuration: 0.5) {
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
          }
            self.prescriptionCollectionView.reloadData()
        }
        
        
    }
    
    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
        return 1
    }
    
    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
    }
    
    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
        return URL(string: "https://placeimg.com/500/500/nature")
    }
}
