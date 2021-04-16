//
//  DataProvider.swift
//  LearnAboutAnimalApp
//
//  Created by skj on 16.4.2021.
//

import Foundation

class DataProvider {
    static func dataTiger() -> [String: String] {
        var data = [String: String]()
        data["name"] = "Tiger"
        data["detail"] = """
Tiger is the biggest cat species. The Siberian tiger is the largest whose weight can reach up to 800 pounds and 11 feet from head to tail. They can be recognized with the fur of dark brown-orange stripes. The tiger is recognized by its stripes because no tiger can have the same stripes.

Tigers are solitary animals and they hunt alone. They are also known for great swimmers and their roar is so powerful that it can be heard miles away. Tigers are carnivores and they hunt other animals including deer, pigs, and even small elephants. But they are also being hunted by humans for fur and body parts and their habitat is also being destroyed by human activities. Due to these activities of humans, they are now endangered animals.
"""
        data["status"] = "Endangered"
        data["classification"] = "Vertibrate"
        data["diet"] = "Carnivore"
        data["lifeSpan"] = "8 - 10 years"
        data["height"] = "70 - 120 cm (Adult)"
        data["weight"] = "Male: 90 - 310 kg (Adult), Female: 65 - 170 kg (Adult)"
        data["habitat"] = "Grasslands, savannas, temperate forests, mangrove swamps, evergreen forests, and Tropical rainforests"
        return data
    }
    
    static func dataElephant() -> [String: String] {
        var data = [String: String]()
        data["name"] = "Elephant"
        data["detail"] = """
Elephants are the largest mammal on earth. They are recognized by their huge body, trunks, and wide ears. African elephant and Asian Elephant differ in many ways with their sizes and weights. The African elephants are larger than Asian and also their ears are larger than Asian elephants. Elephants have thick skin which can be upto 1inch thick and so they are called pachyderms.

Elephants are classified as endangered with only 40000 - 50000 left on earth due to shrinking habitat. Female elephants are more social than male.
"""
        data["status"] = "Endangered"
        data["classification"] = "Vertibrate"
        data["diet"] = "Hervibore"
        data["lifeSpan"] = "Asian elephant: 48 years, African elephant: 60 - 70 years"
        data["height"] = "Asian elephant: 2.8 m, African elephant: 3.2 m"
        data["weight"] = "Asian elephant: 4000 kg, African elephant: 2700 kg - 6000 kg"
        data["habitat"] = "Grasslands, savannas, forests, swamps"
        return data
    }

    static func dataPanda() -> [String: String] {
        var data = [String: String]()
        data["name"] = "Giant Panda"
        data["detail"] = """
Giant Panda or simply panda is a bear which is black and white in color and is considered as a national treasure in China. It is also a symbol of WWF. It is one of the most endandered animal in the world with about less than 2000 in numbers. It is effectively recognized by the huge distinctive black patches around its eyes, ears, and its circular body.

Being mostly dependent on bamboo and most of the time they eat vegetables. Indeed, giant pandas has the digestive system of carnivore. Pandas are good tree climbers and swimmers.
"""
        data["status"] = "Endangered"
        data["classification"] = "Vertibrate"
        data["diet"] = "Almost entirely on leaves, stems, and bamboo"
        data["lifeSpan"] = "14 - 20 years"
        data["height"] = "Upto 150 cm long(Adult)"
        data["weight"] = "100 - 150 kg (Adult)"
        data["habitat"] = "Temperate forests of southwest China"
        return data
    }
    
    static func dataBear() -> [String: String] {
        var data = [String: String]()
        data["name"] = "Polar Bear"
        data["detail"] = """
Polar bear is the largest bear in the world which inhabitat in Artic. They are white in colour and are also considered as symbol of strength and endurance. They spent most of their time in hunting for food and are a very good swimmers. It spends many months at sea so it is also called marine mammal. They feed mainly on seals but they also eat fish, reindeer, eggs etc. when seals are not available.

Global warming has been one of the most challenging factor that has adversely effected the habitat of polar bear. Due to global warming the ice is disappearing and with the disappearance of ice there is no place of the bears to rest. The climate change has threatened the species and has been listed as endangered species.
"""
        data["status"] = "Endangered"
        data["classification"] = "Vertibrate"
        data["diet"] = "Carnivore"
        data["lifeSpan"] = "Can live upto 25 years"
        data["height"] = "8 - 10 feet long (Adult)"
        data["weight"] = "Upto 1700 pounds (Adult)"
        data["habitat"] = "Sea ice covering water"
        return data
    }

}
