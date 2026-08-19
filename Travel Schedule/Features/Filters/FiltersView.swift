//
//  FiltersView.swift
//  Travel Schedule
//
//  Created by Максим on 18.08.2026.
//

import SwiftUI

struct FiltersView: View {
    @Environment(\.dismiss) private var dismiss
    let onApply: (RouteFilters) -> Void
    private var hasSelectedFilters: Bool {
        !filters.selectedTimes.isEmpty && filters.showTransfers != nil
    }
    @State private var filters: RouteFilters
    
    init(
        filters: RouteFilters,
        onApply: @escaping (RouteFilters) -> Void
    ) {
        _filters = State(initialValue: filters)
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
                            if filters.selectedTimes.contains(time) {
                                filters.selectedTimes.remove(time)
                            } else {
                                filters.selectedTimes.insert(time)
                            }
                        } label: {
                            Image(systemName: filters.selectedTimes.contains(time) ? "checkmark.square.fill" : "square")
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
                        filters.showTransfers = true
                    } label: {
                        Image(
                            systemName: filters.showTransfers == true ? "largecircle.fill.circle" : "circle"
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
                        filters.showTransfers = false
                    } label: {
                        Image(
                            systemName: filters.showTransfers == false ? "largecircle.fill.circle" : "circle"
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
            
            if hasSelectedFilters {
                Button {
                    onApply(filters)
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
