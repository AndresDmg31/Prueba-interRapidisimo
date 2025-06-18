//
//  AppDelegate.swift
//  Prueba-interRapidisimo
//
//  Created by Andres Martinez gonzalez on 17/06/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Se crea el modulo inicial usando VIPER.
        let rootViewController = VersionModule.build()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        /// Se configura la ventana principal.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    /// Contenedor persistente para Core Data.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Error al cargar CoreData: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    /// Guarda los cambios en el  Core Data.
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error al guardar: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}

