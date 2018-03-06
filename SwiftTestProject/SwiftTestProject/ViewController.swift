//
//  ViewController.swift
//  SwiftTestProject
//
//  Created by 张留扣 on 2018/3/4.
//  Copyright © 2018年 ___ZLK___. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var listArray = UserDefaults.standard.object(forKey: "list") as? Array<Any>

    //创建tableView对象
    lazy var tableView : UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TO DO LIST"
        //设置UI界面
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listArray = UserDefaults.standard.object(forKey: "list") as? Array<Any>
        if listArray == nil {
            listArray =  Array()
        }
        tableView.reloadData()
    }
    
}

//MARK:-- 设置UI界面
extension ViewController {
    private func setupUI() {
        
        configTableView()
        //设置导航栏
        setNavigationBar()
    }
    
    private func configTableView() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setNavigationBar() {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "add"), for: UIControlState.normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(pushToAddViewController), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    @objc func pushToAddViewController() {
        let addVC = AddViewController()
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
 //MARK:-- Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listArray?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1>创建cell
        let identifier : String = "identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: identifier)
        }
        //2>设置数据
        if listArray != nil {
            let dic = listArray![indexPath.row] as? [String : Any]
            cell?.textLabel?.text = dic?["titletext"] as? String
            cell?.detailTextLabel?.text = dic?["detailtext"] as? String
        }
        
        //3>返回cell
        return cell!//在这个地方返回的cell一定不为nil，可以强制解包
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("我的index为\(indexPath.row)")
//        objects.remove(at: 0)
//        let indexPath = IndexPath(item: 0, section: 0)
//        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            var listArr = UserDefaults.standard.array(forKey: "list")
            if indexPath.row < (listArr?.count)! {
                listArr?.remove(at: indexPath.row)
            }
            UserDefaults.standard.set(listArr, forKey: "list")
            UserDefaults.standard.synchronize()
            
            listArray?.remove(at: indexPath.row)
            self.tableView.reloadData()

        }
    }
    
}
