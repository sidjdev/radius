# **Radius Assignment**

Welcome to the repository for the iOS Application. This readme explains the structure of the project, including a walkthrough of the three main folders in the app: Modules, Models, and Networking. We've organised the app to follow a clean, modular architecture that allows for greater flexibility and improved maintainability.

**Folder Structure**

**Modules:** This folder is the heart of our application. It contains different functional units of the application called Modules. Each module represents a unique feature or a screen in the app. As an example, let's look at the Home module.

**Home:** This folder encapsulates all code related to the Home screen of the application.

**HomeView.swift:** This is the View for the Home screen. It's where all the UI components and layouts for the Home screen are defined.

**HomeVM.swift:** This stands for Home View Model. It's responsible for handling the logic for the Home screen, including calls to the networking layer.


**HomeViewModel**

The HomeViewModel class acts as an intermediary between the HomeView and the model, Facility. This class is responsible for handling the business logic for the Home screen, including making network calls and processing data. This class is a key component of the Model-View-ViewModel (MVVM) architecture and is vital in ensuring separation of concerns in our app's design.

Here's a breakdown of its components and functionalities:

Properties:
@Published var facilities: [Facility](#) = [](#): This is a published array of Facility objects. The @Published property wrapper indicates that any changes to facilities will notify the SwiftUI views that are observing this ViewModel to refresh.

@Published var exclusions: [[Exclusion](#)] = [](#): This is a published 2D array of Exclusion objects. It also triggers a view update when the exclusions change.
var allExclusions: [Exclusion](#) = [](#): This is an array of Exclusion objects derived from the exclusions array.

var exclusionMap: [Exclusion : [Exclusion](#)] = [:](#): This is a dictionary mapping each Exclusion to an array of its Exclusion pairs. This is used for mapping mutual exclusion pairs for efficient lookups.


**Methods:**
fetchProperties(): This function fetches the facility data from the server. It uses the singleton instance of NetworkManager to make the request. On successful retrieval of data, it updates the facilities and exclusions properties and calls mapExclusions() to update the exclusionMap. In case of an error, it simply prints the error message.

mapExclusions(): This is a private helper function used to map each Exclusion object to its mutual exclusions. It takes the 2D exclusions array and converts it into a dictionary for efficient exclusion lookups. This function is called in the success block of the fetchProperties() function.

The **HomeViewModel** is a crucial part of the MVVM pattern, it separates the business logic from the UI, making the code more maintainable, scalable, and testable. The use of SwiftUI's @Published property wrapper allows the ViewModel to notify the View of any state changes, keeping them in sync.

**Models:** This folder houses all the data models used within the application.

**Facility.swift:** This is a data model representing a Facility object. It defines its attributes and potentially any methods associated with handling or manipulating a Facility.

**Networking:** This folder contains all the networking-related code.

**Networking.swift:** This file contains all the networking calls made in the application. It's accessed as a singleton, meaning only one instance of this class exists throughout the application's lifecycle, allowing for a centralized, controlled handling of network requests.


These are key components involved in the networking layer of the application.

APIEndpoint: This is an enumeration defining all the endpoints used in the application. For each case in the enumeration, you define a URL. For now, there's only one case facilityData with a specific URL associated. This setup allows for organized and manageable control of all API endpoints used throughout the application.

NetworkManager: This is a singleton class that manages all the network requests in your application. The singleton pattern is used to ensure that only one instance of the NetworkManager exists throughout the application. Here are its key components:
static let shared = NetworkManager(): This creates a single, shared instance of NetworkManager.


private init() : This private initializer ensures that no other instances of this class can be created from outside this class.
fetchData\<T: Decodable\>(from endpoint: APIEndpoint, dataType: T.Type, completion: @escaping (Result\<T, Error\>) -\> Void): This is a generic function that fetches data from a given endpoint and decodes it into a specified type T. 
The function is generic over any type T that conforms to the Decodable protocol. The function uses the Result type to handle the response. The Result type can represent either a success with a result of type T or a failure with an Error.

NetworkError: This is another enumeration which conforms to the Error protocol. It represents the possible errors that could occur while making network requests. Currently, it handles two cases - invalidURL when the URL is not valid, and noData when there's no data received in the response. This enumeration can be extended to include other types of network-related errors, providing a more robust and granular error handling approach.

These components collectively help to streamline the networking process and make the code more maintainable and scalable. They also provide a solid foundation for comprehensive error handling, making the application more reliable and robust.


**Architectural Pattern**

This application uses the **Model-View-ViewModel (MVVM)** design pattern.

Here are some reasons why we chose to use MVVM:

**Separation of Concerns:** Each component in the MVVM pattern has its own specific roles, which promotes a clear separation of concerns. This improves readability and makes it easier to maintain and scale the code.

**Testability:** With MVVM, it is easy to write unit tests for the ViewModels and Models, which contain the core logic of the application. The View layer is just a reflection of the state of ViewModel, and therefore, can be easily mocked in tests.

**Data Binding:** MVVM promotes a binding mechanism to keep the View and ViewModel synchronized, leading to code that's easier to read and maintain.

**Ease of Integration:** MVVM makes it easy to integrate with other patterns and components like networking services, data repositories, etc.

**Modularity and Reusability:** The design of MVVM promotes modularity and reusability. It's easy to reuse ViewModels for different Views or use multiple ViewModels in a single View if necessary.



Conclusion

Hope this readme provides a clear understanding of the structure and architecture of our iOS application. This setup has been designed keeping best practices in mind to create a scalable, testable, and maintainable codebase.