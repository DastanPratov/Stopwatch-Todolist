//
//  TimeConversions.swift
//  S&T
//
//  Created by Dastan on 28/6/22.
//

import Foundation

func secondsToTime(for seconds: Int) -> String
{
    var eSeconds = seconds
    var minutes = 0
    var hours = 0
    
    if seconds < 60
    {
        return seconds < 10 ? "00:00:0\(seconds)" : "00:00:\(seconds)"
    }
    else if seconds == 60
    {
        return "00:01:00"
    }
    else
    {
        while eSeconds >= 60
        {
            minutes += 1
            eSeconds -= 60
        }
        
        while minutes >= 60
        {
            hours += 1
            minutes -= 60
            
            if hours == 24
            {
                return "24:00:00"
            }
        }
    }
    
    let hourString = hours < 10 ? "0\(hours)" : "\(hours)"
    let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
    let secondsString = eSeconds < 10 ? "0\(eSeconds)" : "\(eSeconds)"
    
    return "\(hourString):\(minutesString):\(secondsString)"
}

enum TMError: Error
{
    case err
}

func timeToSecond(for time: String) throws -> Int
{
    let metrics = time.split(separator: ":")
    
    guard let hours = Int(metrics[0]) else { throw TMError.err }
    guard let minets = Int(metrics[1]) else { throw TMError.err }
    guard let seconds = Int(metrics[2]) else { throw TMError.err }
    
    return hours * 3600 + minets * 60 + seconds
}

