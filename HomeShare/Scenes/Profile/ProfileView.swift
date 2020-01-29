//
//  ProfileView.swift
//  HomeShare
//
//  Created by Nikolaos Athanasiou on 26/1/20.
//  Copyright © 2020 Nikolaos Athanasiou. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @State var showEditModal: Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Profile Image
                ZStack(alignment: .bottomLeading) {
                    StickyImage()
                        .frame(height: 300)
                    
                    
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
                
                // Account Verify Status
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 30)
                        .foregroundColor(.green)
                    HStack {
                        Image("verified_account")
                        Text("Verified Account")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold, design: .default))
                    }.padding(.leading, 6)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    // MARK: - Section 1
                    ZStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 15) {
                            // MARK: Reviews
                            HStack {
                                Image(systemName: "quote.bubble.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22)
                                Text("Reviews")
                                    .foregroundColor(.black)
                                    .font(.system(size: 17, weight:.medium, design: .rounded))
                                Spacer()
                                
                                Group {
                                    Image(systemName: "hand.thumbsup.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20)
                                        .foregroundColor(.green)
                                    Text("34").padding(.trailing, 10)
                                }

                                Group {
                                    Image(systemName: "hand.thumbsdown.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20)
                                        .foregroundColor(.red)
                                    Text("0").padding(.trailing, 5)
                                }

                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.sRGB, red: 60/255, green: 60/255, blue: 60/255, opacity: 0.5))
                            }
                            .padding([.leading,.trailing], 12)
                            
                            
                            // MARK: Guest Status
                            HStack {
                                Image(systemName: "person.3.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.green)
                                    .frame(width: 25)
                                Text("Accepting Guests")
                                    .foregroundColor(.green)
                                    .font(.system(size: 17, weight:.medium, design: .rounded))
                            }
                            .padding([.leading,.trailing], 12)
                        }
                    }
                    .padding([.bottom,.top], 12)
                    .background(Color.white)
                    
                    // MARK: - Section Overview
                    ZStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            // Headline
                            Text("Overview")
                                .font(.headline)
                                .padding(.leading, 7)
                            VStack(alignment: .leading ,spacing: 10) {
                                // Content
                                HStack {
                                    Image(systemName: "message.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20)
                                    Text("Fluent in English")
                                }
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20)
                                    Text("From Greece Athens")
                                }
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20)
                                    Text("Male, 21 years old")
                                }
                                HStack {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20)
                                    Text("Member since Feb 2020")
                                    Spacer() // Necessary to fill the screen width
                                }
                            }
                            .padding(.leading, 12)
                        }
                    }
                    .padding([.bottom,.top], 12)
                    .background(Color.white)

                    
                    // MARK: - Section Description & More
                    ZStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            // Headline
                            Text("Description")
                                .font(.headline)
                                .padding(.leading, 7)
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam eget enim mattis, pellentesque nisl quis, consequat lorem. Quisque pellentesque commodo nisl, sed convallis ligula aliquet at. In gravida tristique nisi eu porta. Pellentesque rhoncus at tortor eu ornare. Suspendisse suscipit maximus lacus id pulvinar. Phasellus ullamcorper orci vel massa aliquet scelerisque. Vestibulum sed enim ante.Integer scelerisque fermentum justo, quis luctus purus hendrerit vitae. Sed non nibh ac augue bibendum mattis. Ut in sodales quam. Nulla fermentum mollis urna, eu tempus ex lobortis at. Curabitur finibus nisi velit, ut fermentum orci gravida sit amet. Mauris nec ex sapien. Pellentesque ultrices ullamcorper purus.")
                                .multilineTextAlignment(.leading)
                                .padding([.leading,.trailing], 12)
                                .padding(.top, 5)
                                .font(.system(size: 17, weight: .light, design: .rounded))
                            // Options
                            VStack(alignment: .leading) {
                                OptionRow(title: "House Information & Rules", style: .normal)
                                OptionRow(title: "Save Profile", style: .normal)
                                OptionRow(title: "Share link to the Profile", style: .normal)
                            }
                        }
                    }
                    .padding(.top, 12)
                    .background(Color.white)

                }
            }
        }
        .navigationBarTitle("Profile", displayMode: .inline)
        .background(Color(red: 242/255, green: 242/255, blue: 247/255))
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
