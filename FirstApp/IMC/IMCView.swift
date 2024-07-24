//
//  IMCView.swift
//  FirstApp
//
//  Created by Sebastian on 19/07/24.
//

import SwiftUI

struct IMCView: View {
    
    @State var gender:String = "M"
    @State var height:Double = 150
    @State var age:Int = 0
    @State var weight:Int = 0

    
    var body: some View {
        VStack{
            HStack{
                ToggleButton(title: "Hombre", imageName: "heart.fill", value: "M", selectedGender: $gender)
                ToggleButton(title: "Mujer", imageName: "star.fill", value: "F",selectedGender: $gender)
            }
            
            HeightCalculator(selectedHeight: $height)
            
            HStack{
                Counter(title: "Edad", selectedValue: $age)
                Counter(title: "Peso", selectedValue: $weight)
            }
            
            IMCCalculatorButton(height: height, weight: Double(weight))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundApp)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("IMC Calculator").foregroundStyle(Color.white)
            }
        }
        
    }
}


struct ToggleButton:View {
    let title:String
    let imageName:String
    let value:String
    @Binding var selectedGender: String
    
    
    var body: some View {
        Button(action: {selectedGender = value}){
            VStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundStyle(Color.white)
                
                InformationText(text: title)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background( value == selectedGender ? Color.backgroundSecondary : Color.backgroundPrimary)
        }
        
        
    }
}



struct InformationText:View {
    let text:String
    
    var body: some View {
        Text(text)
            .foregroundStyle(Color.white)
            .bold()
            .font(.system(size: 30))
    }
}

struct HeightCalculator:View {
    @Binding var selectedHeight:Double
    
    var body: some View {
        VStack{
            Text("Altura").foregroundStyle(Color.gray).font(.title2)
            InformationText(text: "\(Int(selectedHeight)) cm")
            Slider(value: $selectedHeight, in: 100...250, step: 1)
                .padding(.horizontal, 16)
                .accentColor(.purple)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundPrimary)
    }
}


struct Counter:View {
    var title:String
    @Binding var selectedValue:Int
    
    var body: some View {
        VStack{
            Text(title).foregroundStyle(Color.gray).font(.title2)
            InformationText(text: "\(selectedValue)")
            HStack(spacing:15){
                CounterButton(icon: "minus", onPress:{
                    if selectedValue <= 0 { return }
                    selectedValue -= 1
                })
                CounterButton(icon: "plus", onPress: {
                    if selectedValue >= 100 { return }
                    selectedValue += 1
                })
            }.frame(height: 100)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundPrimary)
    }
}

struct CounterButton:View {
    var icon:String
    var onPress:() -> Void
    
    var body: some View {
        Button(action: {onPress()}){
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.white)
                .padding(20)
                .frame(width: 70, height: 70)
        }
        .background(.purple)
        .cornerRadius(100)
    }
}


struct IMCCalculatorButton:View {
    let height:Double
    let weight:Double
    
    var body: some View {
        NavigationStack{
            NavigationLink(destination: IMCResultView(height: height, weight: weight)){
                Text("Calcular")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundStyle(Color.purple)
                    .font(.title)
                    .bold()
                    .background(.backgroundPrimary)
            }
        }
    }
}
#Preview {
    IMCView()
}
