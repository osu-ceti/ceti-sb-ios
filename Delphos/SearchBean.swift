//
//  SearchBean.swift
//  Delphos
//
//  Created by Jith on 09/04/16.
//  Copyright © 2016 Ontoborn. All rights reserved.
//
import UIKit

/**
 * SearchBean Class to store SearchBean details
 * Request sent to REST API JSON
 */
class SearchBean {
    
    var searchType: String?
    
    var isLocation: Bool!
    
    var radius: Int!
    
    var zip: Int!
    
}
