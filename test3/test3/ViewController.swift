//
//  ViewController.swift
//  test3
//
//  Created by Huy Vu on 12/20/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    let imageUrl = URL(string: "https://cdn.oneesports.vn/cdn-data/sites/4/2023/07/Luffy-Gear-5-1024x576.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Sử dụng Kingfisher để hiển thị hình ảnh từ cache
        self.img.kf.setImage(
            with: imageUrl,
            placeholder: nil,
            options: [.cacheOriginalImage, .onlyFromCache]) { result in
                switch result {
                case .success(_):
                    print("Hình ảnh được tải từ cache")
                case .failure(_):
                    // Nếu không có trong cache, tải từ URL và lưu vào cache
                    self.img.kf.setImage(with: self.imageUrl, options: [.cacheOriginalImage]) { result in
                        switch result {
                        case .success(_):
                            print("Hình ảnh được tải và lưu vào cache")
                        case .failure(let error):
                            print("Lỗi khi tải hình ảnh: \(error.localizedDescription)")
                        }
                    }
                }
            }
    }
    
    func checkImageInCache() {
            // Kiểm tra xem ảnh có trong Cache không
            if let url = imageUrl, KingfisherManager.shared.cache.isCached(forKey: url.cacheKey) {
                print("Có ảnh trong Cache")
            } else {
                print("Không có ảnh trong Cache")
            }
        }
    
    
    @IBAction func delete_cache(_ sender: Any) {
        // Kiểm tra Cache trước khi xóa
              checkImageInCache()
        
        
        // Xóa cache của Kingfisher nếu cần
                KingfisherManager.shared.cache.clearMemoryCache()
                KingfisherManager.shared.cache.clearDiskCache()
        
        
        // Kiểm tra lại sau khi xóa Cache
               checkImageInCache()
    }
    
}

