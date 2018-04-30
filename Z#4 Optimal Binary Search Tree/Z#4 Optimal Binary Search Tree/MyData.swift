//
//  MyData.swift
//  Z#4 Optimal Binary Search Tree
//
//  Created by Рома Сорока on 22.04.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import Foundation

class MyData {
  struct Discipline: Equatable & HasNameAndID {
    var name = ""
    var ID = 0
    var teacher: Teacher?
    
    init(){}
    init(name: String, id: Int, teach: Teacher){
      self.name = name
      self.ID = id
      self.teacher = teach
    }

    static func ==(left: Discipline, right: Discipline) -> Bool{
      return left.ID == right.ID && left.name == right.name
    }
  }
  
  class Teacher: Equatable & HasNameAndID {
    var disciplines = [Discipline]()
    func updateTeachers(){
      for i in 0..<disciplines.count {
        disciplines[i].teacher = self
      }
    }
    var name = ""
    var ID = 0
    
    static func ==(left: Teacher, right: Teacher) -> Bool{
      return left.ID == right.ID && left.name == right.name
    }
    
    init(){}
    init(name: String, id: Int, disciplines: [Discipline]){
      self.name = name
      self.ID = id
      self.disciplines = disciplines
    }
    
  }
  
  var disciplines = [Discipline]()
  var teachers = [Teacher]()
  
  init(fileName: String) {
    var data = ""
    
    //            Optional(file:///Users/bbjay/Documents/)
    let dir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let fileURL = dir.appendingPathComponent(fileName)
    //reading
    do {
      data = try String(contentsOf: fileURL)
    }
    catch { print("nope reading")}
    
    //print(data)
    let teacherDatas = data.split(separator: "\n")
    //print(teacherDatas)
    teachers = [Teacher]()
    for teacherData in teacherDatas {
      let teacherAndDisciplines = teacherData.split(separator: ":")
      let teacherNamesAndIDs = teacherAndDisciplines[0].split(separator: " ")
      let disciplineNamesAndIds = teacherAndDisciplines[1].split(separator: " ").map { (s) -> String in
        String(s)
      }
      var disciplines = [Discipline]()
      var discipline = Discipline()
      for (i,nameOrID) in disciplineNamesAndIds.enumerated() {
        if i % 2 == 0 {
          discipline.name = String(nameOrID)
        } else {
          discipline.ID = Int(nameOrID)!
          disciplines.append(discipline)
        }
      }
      teachers.append(Teacher(name: String(teacherNamesAndIDs.first!), id: Int(teacherNamesAndIDs[1])!, disciplines: disciplines))
    }
    for t in teachers {
      t.updateTeachers()
    }
    for teacher in teachers {
      disciplines += teacher.disciplines
    }
  }

  
}
