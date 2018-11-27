//
//  UploadPrescriptionViewController.swift
//  MedicoBox
//
//  Created by SBC on 27/09/18.
//  Copyright © 2018 Aiprous. All rights reserved.
//

import UIKit

class UploadPrescriptionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var youOrderingForViewHightConstraint: NSLayoutConstraint!
    @IBOutlet weak var patientNameViewHightConstraint: NSLayoutConstraint!
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
        prescriptionCollectionView.dataSource = self
        prescriptionCollectionView.delegate = self
        
        //show navigationbar with back button
         self.setNavigationBarItemBackButton()
         self.navigationController?.isNavigationBarHidden = false;
        btnYes.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        btnNo.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        

        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        youOrderingView.isHidden = true;
        youOrderingForViewHightConstraint.constant = 50;
        patientNameViewHightConstraint.constant = 0;
        self.mainViewHightConstraint.constant = -157;
        
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
            }
        }
        
        
    }
    
    @IBAction func btnTakePhotoAction(_ sender: Any) {
        
       self.openCamera()
        
    }
    

    @IBAction func btnChooseFromGalleryAction(_ sender: Any) {
        
        openGallery()
        
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
            
            if(collectionImageArray.count != 0){
                
                self.mainViewHightConstraint.constant = +157;

            }else {
                
            }


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
        
        if(btnYes.isSelected == false){
            
            btnYes.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnNo.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            youOrderingView.isHidden = false;
            youOrderingForViewHightConstraint.constant = 136;
            patientNameViewHightConstraint.constant = 76;

            self.btnYes.isSelected = true;
            
        }else {
            
            btnYes.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            youOrderingView.isHidden = true;
            youOrderingForViewHightConstraint.constant = 50;
            patientNameViewHightConstraint.constant = 0;

            self.btnYes.isSelected = false;
            
        }
    }
    
    
    @IBAction func btnNoAction(_ sender: Any) {
        
        if(btnNo.isSelected == false){
            
            btnNo.setImage(#imageLiteral(resourceName: "radio-active-button"), for: .normal)
            btnYes.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            youOrderingView.isHidden = true;
            youOrderingForViewHightConstraint.constant = 50;
            patientNameViewHightConstraint.constant = 0;

            self.btnNo.isSelected = true;
            
        }else {
            
            btnNo.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
            youOrderingView.isHidden = true;
            youOrderingForViewHightConstraint.constant = 50;
            patientNameViewHightConstraint.constant = 0;

            self.btnNo.isSelected = false;
            
        }
    }
}
