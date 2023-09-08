//
//  MainView.swift
//  Com
//
//  Created by Pierre Idé on 09/07/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height / 10.7
            
            NavigationStack {
                List {
                    NavigationLink {
                        ScanView()
                    } label: {
                        HStack {
                            Image(systemName: "wave.3.left")
                                .foregroundStyle(.accent)
                                .font(.largeTitle)
                            Text("Scan tag")
                                .font(.largeTitle).bold()
                                .padding(.horizontal, 15)
                            Image(systemName: "wave.3.right")
                                .foregroundStyle(.accent)
                                .font(.largeTitle)
                        }
                        .padding([.top, .bottom], height)
                        .frame(maxWidth: .infinity)
                    }
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        VStack {
                            HStack {
                                Image(systemName: "wave.3.right")
                                    .foregroundStyle(.accent)
                                    .font(.largeTitle)
                                Text("Clone tag")
                                    .font(.largeTitle).bold()
                                    .padding(.horizontal, 15)
                                Image(systemName: "wave.3.right")
                                    .foregroundStyle(.accent)
                                    .font(.largeTitle)
                            }
                            Text("Comming soon")
                        }
                        .padding([.top, .bottom], height)
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(true)
                    
                    
                    NavigationLink {
                        WriteView()
                    } label: {
                        HStack {
                            Image(systemName: "wave.3.right")
                                .foregroundStyle(.accent)
                                .font(.largeTitle)
                            Text("Clone tag")
                                .font(.largeTitle).bold()
                                .padding(.horizontal, 15)
                            Image(systemName: "wave.3.left")
                                .foregroundStyle(.accent)
                                .font(.largeTitle)
                        }
                        //                        .disabled(true)
                        //                        .overlay {
                        //                            Text("Comming soon")
                        //                                .font(.title2).bold()
                        //                        }
                        .padding([.top, .bottom], height)
                        .frame(maxWidth: .infinity)
                    }
                }
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    MainView()
}
