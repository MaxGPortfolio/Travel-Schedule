//
//  FiltersView.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: FiltersViewModel
    
    let onApply: (RouteFilters) -> Void
    
    init(
        filters: RouteFilters,
        onApply: @escaping (RouteFilters) -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: FiltersViewModel(filters: filters)
        )
        self.onApply = onApply
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(DepartureTime.allCases, id: \.self) { time in
                    HStack {
                        Text(time.title)
                            .font(.system(size: 17, weight: .regular))
                        
                        Spacer()
                        
                        Button {
                            viewModel.toggle(time)
                        } label: {
                            Image(
                                systemName: viewModel.filters.selectedTimes.contains(time)
                                ? "checkmark.square.fill"
                                : "square"
                            )
                        }
                        .buttonStyle(.plain)
                        .frame(width: 20, height: 20)
                        
                    }
                    .frame(
                        minHeight: 60,
                        maxHeight: 60
                    )
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                HStack() {
                    Text("Да")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlackDay)
                    
                    Spacer()
                    
                    Button {
                        viewModel.selectTransfers(true)
                    } label: {
                        Image(
                            systemName: viewModel.filters.showTransfers == true
                            ? "largecircle.fill.circle"
                            : "circle"
                        )
                        .foregroundStyle(.primary)
                    }
                    .buttonStyle(.plain)
                    .frame(width: 20, height: 20)
                }
                .frame(
                    height: 60
                )
                
                HStack() {
                    Text("Нет")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(.ypBlackDay)
                    
                    Spacer()
                    
                    Button {
                        viewModel.selectTransfers(false)
                    } label: {
                        Image(
                            systemName: viewModel.filters.showTransfers == false
                            ? "largecircle.fill.circle"
                            : "circle"
                        )
                        .foregroundStyle(.primary)
                    }
                    .buttonStyle(.plain)
                    .frame(width: 20, height: 20)
                }
                .frame(
                    height: 60
                )
            }
            
            Spacer()
            
            if viewModel.hasSelectedFilters {
                Button {
                    onApply(viewModel.filters)
                    dismiss()
                } label: {
                    Text("Применить")
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 60,
                            maxHeight: 60,
                        )
                        .foregroundStyle(.ypJustWhite)
                        .font(.system(size: 17, weight: .bold))
                        .background(.ypBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.bottom, 24)
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color.ypWhiteDay.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        FiltersView(
            filters: RouteFilters(
                selectedTimes: [.morning, .night],
                showTransfers: false
            )
        ) { filters in
            print(filters)
        }
    }
}
