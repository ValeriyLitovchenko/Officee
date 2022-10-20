//
//  BaseView.swift
//
//  Created by Valeriy L on 15.09.2022.
//

import UIKit

/**
 Base class for custom reusable views implemented in xib files.
 All view controller's views are inherited from BaseView.
 */
open class BaseView: UIView, NibInstantiable {
    
  // MARK: - Constructor
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: - Destructor
  
  deinit {
    debugPrint("Did deinit \(String(describing: type(of: self)))")
  }
  
  // MARK: - Private functions
  
  private func setup() {
    guard let view = Self.nib.instantiate(withOwner: self).first as? UIView else { return }
    
    view.frame = bounds
    addPinnedSubview(view)
    sendSubviewToBack(view)
  }
}
