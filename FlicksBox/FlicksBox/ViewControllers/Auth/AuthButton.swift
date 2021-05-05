import Botticelli
import UIKit

final class AuthButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        backgroundColor = #colorLiteral(red: 0.2627134919, green: 0.2627637982, blue: 0.2627063692, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
