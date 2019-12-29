//
//  AccountView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 28/12/19.
//  Copyright © 2019 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    ZStack(alignment: .bottomLeading) {
                        StickyImage().frame(height: 300)
                        
                        
                        
                        VStack(alignment: .leading) {
                            Text("Nikolaos Athanasiou")
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .black, design: .default))
                            Text("Messini, Peloponnisos, Greece")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold, design: .default))
                        }
                        .padding(.leading)
                        .padding(.bottom)
                    }
                        

                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 30)
                            .foregroundColor(.green)
                        HStack {
                            Image("verified_account")
                            Text("Verified Account")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .bold, design: .default))
                        }.padding(.leading)
                    }
                    
                    Form {
                        ForEach(Option.options,id: \.id) { settingOption in
                            OptionRow(option: settingOption)
                        }
                    }
                    .scaledToFit()
                    .disabled(true)
                }
            }
        }.navigationBarTitle("Home", displayMode: .automatic)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct OptionRow: View {
    let option: Option
    var body: some View {
        Group() {
            if option.isAddSection {
                Section {
                    OptionSettingsView(option: option)
                }
            } else {
                OptionSettingsView(option: option)
            }
        }
    }
}


struct OptionSettingsView : View {
    let option: Option
    
    var body: some View {
        return NavigationLink(destination: RegisterView()) {
            HStack {
                Image("default")
                    .resizable()
                    .cornerRadius(12)
                    .frame(width: 25, height: 25)
                    .clipped()
                    .aspectRatio(contentMode: .fit)
                Text(option.title)
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
            }
        }
    }
}
