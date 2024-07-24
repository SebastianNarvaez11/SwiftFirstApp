//
//  IMCResultView.swift
//  FirstApp
//
//  Created by Sebastian on 20/07/24.
//

import SwiftUI

struct IMCResultView: View {
    let height:Double
    let weight:Double
    
    var body: some View {
        let imcValue = calculateIMC(height: height, weight: weight)
        let resultInfo = getIMCInformationResult(imcResult: imcValue)
        
        VStack{
            Text("Tu resultado")
                .foregroundStyle(Color.white)
                .bold()
                .font(.title)
            VStack(spacing:100){
                Text(resultInfo.0)
                    .foregroundStyle(Color(resultInfo.1))
                    .font(.title)
                    .bold()
                Text("\(imcValue, specifier: "%.2f")")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 100))
                    .bold()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.backgroundPrimary)
            .cornerRadius(20)
            .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.backgroundApp)
    }
}


func calculateIMC (height:Double, weight:Double) -> Double {
    let result = weight / ((height/100) *  (height/100))
    return result
}

func getIMCInformationResult (imcResult: Double) ->  (String, Color){
    let title:String
    let color:Color
    
    switch imcResult {
    case 0.00...19.99:
        title = "Peso bajo"
        color = .yellow
    case 20.00...24.99:
        title = "Peso normal"
        color = .green
    case 25.00...29.99:
        title = "Sobrepeso"
        color = .orange
    case 30.00...100:
        title = "Obesidad"
        color = .red
        
    default:
        title = "Error"
        color = .gray
    }
    
    
    return (title, color)
}

#Preview {
    IMCResultView(height: 172, weight: 70)
}
