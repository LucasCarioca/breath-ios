//
//  UpdateChangeSummary.swift
//  Count my breaths
//
//  Created by Lucas Desouza on 10/21/20.
//  Copyright © 2020 Lucas Desouza. All rights reserved.
//

import SwiftUI

struct UpdateChangeView: View {
    var version: String
    var versionDescription: String
    var changes: [Change]
    var action: () -> Void
    var body: some View {
        ZStack{
            Theme.colors.background.edgesIgnoringSafeArea(.all)
            TabView{
                UpdateChangeTitleCard(version: version, description: versionDescription)
                ForEach(changes, id: \.self) { change in
                    UpdateChangeCard(title: change.title, description: change.description, image: change.image)
                }
                UpdateChangeFinalCard(action: self.action)
            }.tabViewStyle(PageTabViewStyle())
        }
    }
}

struct UpdateChangeTitleCard: View {
    var version: String
    var description: String
    var body: some View {
        VStack {
            Text("Version \(version) is here!")
                .font(.title)
                .foregroundColor(Theme.colors.text)
                .padding(.top, 50)
                .multilineTextAlignment(.center)
            Spacer()
            Image("icon")
            Spacer()
            Text(description)
                .padding()
                .foregroundColor(Theme.colors.text)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct UpdateChangeCard: View {
    var title: String
    var description: String
    var image: String
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(Theme.colors.text)
                .padding(.top, 50)
                .multilineTextAlignment(.center)
            Spacer()
            Image(systemName: image)
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(Theme.colors.primary)
                
            Spacer()
            Text(description)
                .padding()
                .foregroundColor(Theme.colors.text)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct UpdateChangeFinalCard: View {
    var action: () -> Void
    var body: some View {
        VStack {
            Text("All done")
                .font(.title)
                .foregroundColor(Theme.colors.text)
                .multilineTextAlignment(.center)
                .padding(.top, 50)
            Text("Lets get started!")
                .font(.title)
                .foregroundColor(Theme.colors.text)
                .multilineTextAlignment(.center)
                
            Spacer()
            Image("icon")
            Spacer()
            Button(action: self.action) {
                Text("Continue to app")
                    .padding()
                    .foregroundColor(Theme.colors.background)
                    .background(Theme.colors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }.accessibility(label: Text("Continue to app"))
            Spacer()
        }
    }
}

struct UpdateChangeFinalCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Theme.colors.background.edgesIgnoringSafeArea(.all)
            UpdateChangeFinalCard(action: {})
        }
    }
}


struct UpdateChangeCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Theme.colors.background.edgesIgnoringSafeArea(.all)
        UpdateChangeCard(title:"Cool new feature!", description: "New version has been released with adjustments to general style.", image: "paintbrush.fill")
        }
    }
}

struct UpdateChangeTitleCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Theme.colors.background.edgesIgnoringSafeArea(.all)
        UpdateChangeTitleCard(version:"1.0.0", description: "New version has been released with adjustments to general style.")
        }
    }
}

struct UpdateChangeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateChangeView(version: "1.1.1", versionDescription: "New stuff coming your way!!", changes: [
            Change(title: "Fresher look", description: "Improvements to styleing", image: "paintbrush.fill")
        ], action: {})
    }
}
