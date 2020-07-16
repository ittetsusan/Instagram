//
//  CommentViewController.swift
//  Instagram
//
//  Created by 大場一徹 on 2020/07/11.
//  Copyright © 2020 ittetsu.ooba. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var captionLabel2: UILabel!
    @IBOutlet weak var commentWritten: UITextField!
    @IBAction func commentDidCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func commentPost(_ sender: Any) {
        var commentUpdateValue: FieldValue
        // FireStoreに投稿データを保存する
        let name2 = Auth.auth().currentUser?.displayName
        let commentDic = "\(name2!) \(self.commentWritten.text!)"
        commentUpdateValue = FieldValue.arrayUnion([commentDic])
        let commentRef = Firestore.firestore().collection(Const.PostPath).document(postData2.id)
        print(postData2.id)
        print(commentDic)
        commentRef.updateData(["comment" : commentUpdateValue])
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    var postData2: PostData!
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        
        self.captionLabel2.text = "\(postData2.name!) : \(postData2.caption!)"
    }
}
