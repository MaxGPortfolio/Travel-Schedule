//
//  CarrierInfoView.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import SwiftUI

struct CarrierInfoView: View {
    let carrier: Carrier
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white)

                Image(carrier.logoName)
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 104)
            
            Text(carrier.name)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlackDay)
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 12)
                Text("E-mail")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlackDay)
                Text(carrier.email)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlue)
                Spacer(minLength: 24)
                Text("Телефон")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.ypBlackDay)
                Text(carrier.phone)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypBlue)
                Spacer(minLength: 12)
            }
            .frame(
                maxHeight: 120
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16)
        .padding(.horizontal, 16)
        .background(Color.ypWhiteDay.ignoresSafeArea())
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CarrierInfoView(carrier: MockData.fgc)
}
