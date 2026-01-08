//
//  TableViewController.swift
//  Table
//
//  Created by hanmin on 2026-01-08.
//

import UIKit

// 기본 세팅 목록
var items = ["책 구매","철수와 약속", "스터디 준비하기"]
var itemsImageFile = ["cart", "clock", "pencil"]

// 테이블뷰는 사용 방식이 정형화 되어있는 경우가 많기 때문에, 주로 쓰이는 기능을 기본적으로 주석으로 제공함
class TableViewController: UITableViewController {
    // 테이블 뷰 아웃렛 변수
    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        // 왼쪽에 edit 바 버튼 만들기
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // 위의 viewDidLoad와 같은 범주의 함수
    // viewDidLoad와 다르게, 뷰가 노출될 때 마다 호출된다.
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }

    // MARK: - Table view data source

    // 테이블 뷰에 섹션이 몇 개 있는가
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 한 섹션에 행이 몇 개 있는가
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    // 테이블 뷰의 cell을 만드는 함수
    // cell: UITableView 안에서 한 행을 표현하는 재사용 가능한 뷰 객체
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell은 새로 만들지 않고 돌려쓰겠다
        // identifier가 myCell인 cell이 이미 있으면 가져오고, 없으면 새로 만들기
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        // cell에 내용 채우기
        cell.textLabel?.text = items[indexPath.row]
        cell.imageView?.image = UIImage(named: itemsImageFile[indexPath.row])

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    // 셀을 삭제하는 메서드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            items.remove(at: indexPath.row)
            itemsImageFile.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // 삭제 메서드의 'Delete'를 한글로 수정
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

    // Override to support rearranging the table view.
    // cell의 순서를 변경하는 메서드
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = items[fromIndexPath.row]
        let itemImageToMove = itemsImageFile[fromIndexPath.row]
        items.remove(at: fromIndexPath.row)
        itemsImageFile.remove(at: fromIndexPath.row)
        items.insert(itemToMove, at: to.row)
        itemsImageFile.insert(itemImageToMove, at: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // DetailViewController로 변경될 때 관련 정보들을 준비
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        // identifier의 이름이 sgDetail인 세그웨이라면 해당 셀의 정보를 이동시킨다.
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[indexPath!.row])
        }
            
    }

}
