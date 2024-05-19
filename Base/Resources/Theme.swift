import Foundation
import SwiftUI


struct CustomColor {
    static let navy = Color(red: 35/255, green: 41/255, blue: 70/255, opacity: 1)
    static let yellow = Color(red: 225/255, green: 185/255, blue: 41/255, opacity: 1)
    static let defaultBackgroundColor = Color(red: 248/255, green: 248/255, blue: 248/255, opacity: 1)
    static let initialsCircleColor = Color(red: 192/255, green: 203/255, blue: 255/255, opacity: 1)
    static let textFieldColor = Color(red: 239/255, green: 239/255, blue: 239/255, opacity: 1)
    static let formBorderColor = Color(red: 233/255, green: 233/255, blue: 233/255, opacity: 1)
    static let PlaceholderColor = Color(red: 166/255, green: 166/255, blue: 166/255, opacity: 1)
    
    
//    static let purple = Color("AccentColor")
//    static let lightGrey = Color("lightgrey")
//    static let grey = Color("grey")
//    static let greySearch = Color("greysearch")
//
//    static let searchColor = Color("searchColor")
//    static let greyCard = Color("greyCard")
//    static let card = Color("card")
////    static let textFieldColor = Color("TextFieldColor")
////    static let PlaceholderColor = Color("PlaceholderColor")
//
//    static let initialsCircleColor = Color("InitialsCircleColor")
//    static let formBorderColor = Color("FormBorderColor")
//    static let greyFont = Color("greyfont")
//
//    static let sideMenuGrey = Color("sideMenuGrey")
//    static let editColor = Color("editColor")
    
    
}
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}



enum Theme {}


extension UIColor {
  
  // MARK: - Public colors

  static let primary = UIColor(red: 0.17, green: 0.17, blue: 0.17, alpha: 1)
  static let colorOverPrimary = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  static let secondary = #colorLiteral(red: 0.8477005959, green: 0.06926666945, blue: 0.4081423879, alpha: 1)
  static let lightSecondary = #colorLiteral(red: 1, green: 0.1777058244, blue: 0.5227459669, alpha: 1)
  static let background = #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 1)
  static let text = #colorLiteral(red: 0.7019607843, green: 0.8941176471, blue: 0.9764705882, alpha: 1)
  static let gray = #colorLiteral(red: 0.6291773915, green: 0.6292702556, blue: 0.6291571259, alpha: 1)
  static let lightGray = #colorLiteral(red: 0.746637404, green: 0.7467463017, blue: 0.7466138005, alpha: 1)
  static let headerBackground = #colorLiteral(red: 0.9718168378, green: 0.9772771001, blue: 0.9771065116, alpha: 1)
  static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
  static let offWhite = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
  static let black = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1)
    
  static let orange_100 = UIColor(red: 1, green: 0.57, blue: 0.27, alpha: 1)
  static let orange_200 =  UIColor(red: 0.98, green: 0.48, blue: 0.13, alpha: 1)
   
  static let lightOrange = #colorLiteral(red: 1, green: 0.7506304383, blue: 0, alpha: 1)
  static let skyBlue = #colorLiteral(red: 0, green: 0.8665087819, blue: 1, alpha: 1)
  static let blue = #colorLiteral(red: 0, green: 0.6568392515, blue: 0.9330832958, alpha: 1)
  static let shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
  static let green = #colorLiteral(red: 0, green: 0.6725387573, blue: 0.7495848536, alpha: 1)
  static let lightBlue = #colorLiteral(red: 0.3921568627, green: 0.7176470588, blue: 0.9921568627, alpha: 1)
  static let purple = #colorLiteral(red: 0.2352941176, green: 0.1764705882, blue: 0.6274509804, alpha: 1)
  static let grey_100 = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)
  static let grey_200 = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
  static let grey_300 = #colorLiteral(red: 0.6941176471, green: 0.7019607843, blue: 0.7529411765, alpha: 1)
  static let grey_400 = #colorLiteral(red: 0.5882352941, green: 0.6, blue: 0.6705882353, alpha: 1)
  static let grey_500 = #colorLiteral(red: 0.4862745098, green: 0.5019607843, blue: 0.5843137255, alpha: 1)
  static let grey_600 = #colorLiteral(red: 0.3960784314, green: 0.4117647059, blue: 0.4901960784, alpha: 1)
  static let grey_700 = #colorLiteral(red: 0.2862745098, green: 0.3137254902, blue: 0.3882352941, alpha: 1)
  static let grey_800 = #colorLiteral(red: 0.2, green: 0.2235294118, blue: 0.3294117647, alpha: 1)
  static let blue_100 = #colorLiteral(red: 0.9019607843, green: 0.9647058824, blue: 0.9921568627, alpha: 1)
  static let blue_200 = #colorLiteral(red: 0.7019607843, green: 0.8941176471, blue: 0.9764705882, alpha: 1)
  static let blue_300 = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9215686275, alpha: 1)
  static let blue_400 = #colorLiteral(red: 0.09803921569, green: 0.4705882353, blue: 0.8039215686, alpha: 1)
  static let fuschia_100 = #colorLiteral(red: 1, green: 0.9215686275, blue: 0.9529411765, alpha: 1)
  static let fuschia_200 = #colorLiteral(red: 0.9960784314, green: 0.7647058824, blue: 0.8549019608, alpha: 1)
  static let fuschia_300 =  #colorLiteral(red: 1, green: 0.1921568627, blue: 0.5098039216, alpha: 1)
  static let fuschia_400 = #colorLiteral(red: 0.7254901961, green: 0.09411764706, blue: 0.4, alpha: 1)
  static let majorelle_100 = #colorLiteral(red: 0.9294117647, green: 0.9176470588, blue: 0.9882352941, alpha: 1)
  static let majorelle_200 = #colorLiteral(red: 0.7843137255, green: 0.7568627451, blue: 0.9647058824, alpha: 1)
  static let majorelle_300 = #colorLiteral(red: 0.2745098039, green: 0.1921568627, blue: 0.8823529412, alpha: 1)
  static let majorelle_400 = #colorLiteral(red: 0.1921568627, green: 0.1333333333, blue: 0.6196078431, alpha: 1)
  static let saffron_100 = UIColor(red: 1, green: 0.91, blue: 0.69, alpha: 1)
  static let saffron_200 = #colorLiteral(red: 1, green: 0.8156862745, blue: 0.5803921569, alpha: 1)
  static let saffron_300 = #colorLiteral(red: 1, green: 0.6274509804, blue: 0.1568627451, alpha: 1)
  static let saffron_400 = #colorLiteral(red: 0.7098039216, green: 0.4235294118, blue: 0.06274509804, alpha: 1)
  static let turquoises_100 = #colorLiteral(red: 0.9058823529, green: 0.9647058824, blue: 0.9764705882, alpha: 1)
  static let turquoises_200 = #colorLiteral(red: 0.7137254902, green: 0.8941176471, blue: 0.9254901961, alpha: 1)
  static let turquoises_300 = #colorLiteral(red: 0.0431372549, green: 0.6431372549, blue: 0.7529411765, alpha: 1)
  static let turquoises_400 = #colorLiteral(red: 0.03137254902, green: 0.4509803922, blue: 0.5254901961, alpha: 1)
  static let red_100 = #colorLiteral(red: 0.9843137255, green: 0.9176470588, blue: 0.9058823529, alpha: 1)
  static let red_200 = #colorLiteral(red: 0.968627451, green: 0.8352941176, blue: 0.8078431373, alpha: 1)
  static let red_300 = #colorLiteral(red: 0.8509803922, green: 0.1803921569, blue: 0.04705882353, alpha: 1)
  static let red_400 = #colorLiteral(red: 0.5960784314, green: 0.1254901961, blue: 0.03137254902, alpha: 1)
  static let green_100 = UIColor(red: 0.58, green: 0.74, blue: 0.46, alpha: 1)
  static let green_200 = UIColor(red: 0.45, green: 0.6, blue: 0.33, alpha: 1)
    static let green_300 = UIColor(red: 0.4, green: 0.52, blue: 0.3, alpha: 1)
  static let green_400 = UIColor(red: 0.93, green: 0.95, blue: 0.91, alpha: 1)
  static var logoutButton: UIColor {
    secondary
  }
  static var accountViewBackground: UIColor {
    primary
  }
  static var accountViewText: UIColor {
    text
  }
  static var accountViewArrow: UIColor {
    blue_200
  }
  static var tabviewBackground: UIColor {
    white
  }
  static var rechargePointsColor: UIColor {
    grey_100
  }
  static var error: UIColor {
    return secondary
  }
  static var alarmingTier: UIColor {
    return secondary
  }
  static var midwayTier: UIColor {
    return orange
  }
  static var aboveMidTier: UIColor {
    return green
  }
  static var success: UIColor {
    return green
  }
  static var actionSheetSuccess: UIColor {
    return green
  }
  
  static let buttonDisabledColor = secondary.withAlphaComponent(0.2)
  
  // MARK: - Private colors

}

extension NumberFormatter {
    static func localizedNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ar")

        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}


