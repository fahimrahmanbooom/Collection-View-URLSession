
import Foundation

struct Hero : Decodable {
    
    let id : Int?
    let localized_name : String?
    let primary_attr : String?
    let attack_type : String?
    let roles : [String]?
    let base_health : Int?
    let attack_range : Int?
    let attack_rate : Double?
    let move_speed : Int?
    let legs : Int?
    let img : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case localized_name = "localized_name"
        case primary_attr = "primary_attr"
        case attack_type = "attack_type"
        case roles = "roles"
        case base_health = "base_health"
        case attack_range = "attack_range"
        case attack_rate = "attack_rate"
        case move_speed = "move_speed"
        case legs = "legs"
        case img = "img"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        localized_name = try values.decodeIfPresent(String.self, forKey: .localized_name)
        primary_attr = try values.decodeIfPresent(String.self, forKey: .primary_attr)
        attack_type = try values.decodeIfPresent(String.self, forKey: .attack_type)
        roles = try values.decodeIfPresent([String].self, forKey: .roles)
        base_health = try values.decodeIfPresent(Int.self, forKey: .base_health)
        attack_range = try values.decodeIfPresent(Int.self, forKey: .attack_range)
        attack_rate = try values.decodeIfPresent(Double.self, forKey: .attack_rate)
        move_speed = try values.decodeIfPresent(Int.self, forKey: .move_speed)
        legs = try values.decodeIfPresent(Int.self, forKey: .legs)
        img = try values.decodeIfPresent(String.self, forKey: .img)
    }
}
