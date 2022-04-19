//
//  ListView.swift
//  ToDoList
//
//  Created by Manoel Leal on 04/04/22.
//

import SwiftUI


/*
 * This view is about the screen of To do list
 * Each item is itered by ForEach
 * listViewModel manage ListRowItens
 */
struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty{
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List{
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear){
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(leading: EditButton(),
                            trailing:
                                NavigationLink("Add", destination: AddView()))
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews:some View {
        NavigationView{
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}


