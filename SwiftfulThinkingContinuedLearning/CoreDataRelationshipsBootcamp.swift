//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Juan David Gutierrez Olarte on 29/07/25.
//

import SwiftUI
import CoreData

// 3 entities
// Business entity
// Department entity
// Employee entity


@Observable class CoreDataManager {
    static let instance = CoreDataManager() // Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    init(){
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Error loading core data \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving CoreData\(error.localizedDescription)")
        }
        
    }
}

@Observable class CoreDataRelationshipViewModel {
    
    let manager = CoreDataManager.instance
    var businesses: [BusinessEntity] = []
    var departments: [DepartmentEntity] = []
    var employees: [EmployeeEntity] = []
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        
        let sort = NSSortDescriptor(
            keyPath: \BusinessEntity.name,
            ascending: true
        )
        request.sortDescriptors = [sort]
        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
        
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
        
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
        
    }
    
    func getEmployees(forBusinesses business: BusinessEntity) {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        let filter = NSPredicate(format: "business == %@", business)
        request.predicate = filter
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
    }
    
    
    init () {
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        
        // add existing departments to the new business
//        newBusiness.deparments = [departments[0],departments[1]]
        
        // add existing employees to the new business
//        newBusiness.employees = [employees[2]]
        
        // add new business to the existing department
//        newBusiness.addToDeparments(<#T##value: DepartmentEntity##DepartmentEntity#>)
        
        // add new business to existing employee
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDeparment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0],businesses[1],businesses[2]]
//        newDepartment.employees = [employees[1]]
//        newDepartment.addToEmployees(employees[2])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 21
        newEmployee.dateJoined = Date()
        newEmployee.name = "Luis"
        
        newEmployee.business = businesses[2]
        newEmployee.deparment = departments[6]
        save()
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[0]
        existingBusiness.addToEmployees(employees[0])
        save()
    }
    
    func updateDepartment() {
        let existingDepartment = departments[2]
        existingDepartment.addToEmployees(employees[2])
        save()
    }
    
    func deleteDepartment() {
        let department = departments[2]
        manager.context.delete(department)
        save()
    }
    
    func save(){
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.manager.save()
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
        }
    }
    
    
}

struct CoreDataRelationshipsBootcamp: View {
    
    @State var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        vm.updateDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.blue
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(entity: employee)
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .fontWeight(.bold)
            
            if let departments = entity.deparments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(
            Color.gray.clipShape(RoundedRectangle(cornerRadius: 10)).opacity(0.5)
        )
        .shadow(radius: 8)
    }
}

struct DepartmentView: View {
    
    let entity: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .fontWeight(.bold)
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(
            Color.green.clipShape(RoundedRectangle(cornerRadius: 10)).opacity(0.5))
        .shadow(radius: 8)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .fontWeight(.bold)
            
            Text("Age: \(entity.age)")
            Text("Date Joined: \(entity.dateJoined ?? Date())")
            
            Text("Business:")
                .bold()
            
            Text(entity.business?.name ?? "")
            
            Text("Deparment:")
                .bold()
            
            Text(entity.deparment?.name ?? "")
            
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(
            Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)).opacity(0.5))
        .shadow(radius: 8)
    }
}
