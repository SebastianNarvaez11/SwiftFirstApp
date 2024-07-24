//
//  TextFieldExample.swift
//  FirstApp
//
//  Created by Sebastian on 18/07/24.
//

import SwiftUI

struct TextFieldExample: View {
    @State var email:String = ""
    @State var password:String = ""
    
    
    var body: some View {
        VStack(){
            TextField("Email", text:$email)
                .padding(10)
                .background(.gray.opacity(0.2))
                .cornerRadius(25) // Redondeo de esquinas al fondo
                .overlay( // Borde aplicado como una capa superpuesta
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.gray, lineWidth: 0.2)
                )
            
            TextField("password", text:$password)
                .padding(10)
                .background(.gray.opacity(0.2))
                .cornerRadius(25) // Redondeo de esquinas al fondo
                .overlay( // Borde aplicado como una capa superpuesta
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.gray, lineWidth: 0.2)
                )
            
            
            Button("Sign in", action: {
                print(email, password)
            })
        }.padding(20)
    }
}

#Preview {
    TextFieldExample()
}
