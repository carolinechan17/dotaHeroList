//
//  ContentView.swift
//  dotaHeroList
//
//  Created by Caroline Chan on 03/10/22.
//

import SwiftUI

struct ContentView: View {
    private var dotaServices: DotaServices = DotaServices()
    private var userDefaults: UserDefaults = UserDefaults.standard
    @State private var agiHero: DotaModel = []
    @State private var intHero: DotaModel = []
    @State private var strHero: DotaModel = []
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Agi Hero")) {
                    ForEach(agiHero, id: \.id){ hero in
                        Label(hero.localizedName, systemImage: "person.fill")
                            .foregroundColor(.yellow)
                    }
                }
                
                Section(header: Text("Int Hero")) {
                    ForEach(intHero, id: \.id){ hero in
                        Label(hero.localizedName, systemImage: "person.fill")
                            .foregroundColor(.orange)
                    }
                }
                
                Section(header: Text("Str Hero")) {
                    ForEach(strHero, id: \.id){ hero in
                        Label(hero.localizedName, systemImage: "person.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                classifyHero()
            }
            .listStyle(.sidebar)
            .navigationTitle("Dota Heroes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    //MARK: Function to classify hero to 3 different kinds
    func classifyHero() {
        let datas = getData()
        
        for data in datas {
            switch data.primaryAttr {
            case "agi":
                agiHero.append(data)
            case "int":
                intHero.append(data)
            case "str":
                strHero.append(data)
            default:
                continue
            }
        }
    }
    
    //MARK: Function to get data either from local or api
    func getData() -> DotaModel{
        if let data = getDataFromLocal(DotaModel.self, with: "heroData") {
            return data
        } else {
            Task {
                let dataApi = await getHeroFromApi() ?? []
                return dataApi
            }
        }
        return []
    }
    
    //MARK: Function to get data from Api
    func getHeroFromApi() async -> DotaModel? {
        let data = try? await dotaServices.getHero(endPoint: .getHero)
        
        //MARK: After successfully fetched data, set data to local
        setDataToLocal(object: data, with: "heroData")
        return data
    }
    
    //MARK: Generic function to set data from local
    func setDataToLocal<T: Codable>(object: T, with key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    //MARK: Generic function to get data from local
    func getDataFromLocal<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data else {return nil}
        return try? decoder.decode(type.self, from: data)
    }
}
