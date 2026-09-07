//
//  APITester.swift
//  Travel Schedule
//
//  Created by Максим on 09.07.2026.
//
import OpenAPIRuntime
import OpenAPIURLSession

final class APITester {
    // Функция для тестового вызова API
    static func testFetchStations() {
        // Создаём Task для выполнения асинхронного кода
        Task {
            do {
                // 1. Создаём экземпляр сгенерированного клиента
                let client = Client(
                    // Используем URL сервера, также сгенерированный из openapi.yaml (если он там определён)
                    serverURL: try Servers.Server1.url(),
                    // Указываем, какой транспорт использовать для отправки запросов
                    transport: URLSessionTransport()
                )
                
                // 2. Создаём экземпляр нашего сервиса, передавая ему клиент и API-ключ
                let service = NearestStationsService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d" // !!! ЗАМЕНИТЕ НА СВОЙ РЕАЛЬНЫЙ КЛЮЧ !!!
                )
                
                // 3. Вызываем метод сервиса
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177, // Пример координат
                    lng: 30.319163, // Пример координат
                    distance: 50    // Пример дистанции
                )
                
                // 4. Если всё успешно, печатаем результат в консоль
                print("Successfully fetched stations: \(stations)")
            } catch {
                // 5. Если произошла ошибка на любом из этапов (создание клиента, вызов сервиса, обработка ответа),
                //    она будет поймана здесь, и мы выведем её в консоль
                print("Error fetching stations: \(error)")
                // В реальном приложении здесь должна быть логика обработки ошибок (показ алерта и т. д.)
            }
        }
    }
    
    static func testSearchRoutes() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = SearchRoutesService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
                )
                
                print("Fetching routes...")
                
                let routes = try await service.searchRoutes(
                    from: "c213",
                    to: "c2"
                )
                
                print("Successfully fetched routes:")
                print(routes)
                
            } catch {
                print("Error fetching routes: \(error)")
            }
        }
    }
    
    static func testStationSchedule() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = StationScheduleService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
                )
                
                print("Fetching schedule...")
                
                let schedule = try await service.fetchStationSchedule(
                    station: "s9600213"
                )
                
                print("Successfully fetched schedule:")
                print(schedule)
            } catch {
                print("Error fetching schedule: \(error)")
            }
        }
    }
    
    static func testThreadStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = ThreadStationsService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
                )
                
                print("Fetching thread stations...")
                
                let threadStations = try await service.fetchThreadStations(
                    uid: "SU-1484_260710_c26_12"
                )
                
                print("Successfully fetched thread stations:")
                print(threadStations)
            } catch {
                print("Error fetching thread stations: \(error)")
            }
        }
    }

    static func testNearestSettlement() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = NearestSettlementService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
                )
                
                print("Fetching nearest settlement...")
                
                let settlement = try await service.fetchNearestSettlement(
                    lat: 50.4516962252837,
                    lng: 40.1392928134917
                )
                
                print("Successfully fetched nearest settlement:")
                print(settlement)
            } catch {
                print("Error fetching nearest settlement: \(error)")
            }
        }
    }

    static func testCarrierInfo() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = CarrierInfoService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
                )
                
                print("Fetching carrier info...")
                
                let carrierInfo = try await service.fetchCarrierInfo(
                    code: 680
                )
                
                print("Successfully fetched carrier info:")
                print(carrierInfo)
            } catch {
                print("Error fetching carrier info: \(error)")
            }
        }
    }

    static func testAllStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = AllStationsService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
                )
                
                print("Fetching all stations...")
                
                let allStations = try await service.fetchAllStations()
                
                print("Successfully fetched all stations")
                print("Countries count: \(allStations.countries?.count ?? 0)")
            } catch {
                print("Error fetching all stations: \(error)")
            }
        }
    }
    
    
    static func testCopyright() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = CopyrightService(
                    client: client,
                    apikey: "1c9d5291-8aa4-4fb0-983d-4c5c4915e07d"
                )
                
                print("Fetching copyright...")
                
                let copyright = try await service.fetchCopyright()
                
                print("Successfully fetched copyright:")
                print(copyright)
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
}
