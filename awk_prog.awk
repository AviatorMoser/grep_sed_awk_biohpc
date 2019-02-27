

    # We can also define functions in AWK
    
    function dec_dms(coord_lat, coord_lon) {
        dms_lat["deg"] = int(coord_lat)
        rem_deg = sqrt( (coord_lat - dms_lat["deg"])*(coord_lat - dms_lat["deg"]) )
        dms_lat["min"] = int(rem_deg*60)
        rem_min = rem_deg*60 - dms_lat["min"]
        dms_lat["sec"] = int(rem_min*60)

        # conditional statement to note which hemisphere
        if (coord_lat < 0) {
            dms_lat["hem"] = "S"
            dms_lat["deg"] = -1*dms_lat["deg"]
        }

        dms_lon["deg"] = int(coord_lon)
        rem_deg = sqrt( (coord_lon - dms_lon["deg"])*(coord_lon - dms_lon["deg"]) )
        dms_lon["min"] = int(rem_deg*60)
        rem_min = rem_deg*60 - dms_lon["min"]
        dms_lon["sec"] = int(rem_min*60)

        # conditional statement to note which hemisphere
        if (coord_lon < 0) {
            dms_lon["hem"] = "W"
            dms_lon["deg"] = -1*dms_lon["deg"]
        }
    }   

    BEGIN { FS = ","
        print "Canada Airports Between 40th and 50th parallels"
        print "==============================================="
        
        # single dimensional arrays are allowed in AWK
        # Here we initialize an array for converting coordinates into deg-min-sec format

        dms_lat["deg"] = 0
        dms_lat["min"] = 0
        dms_lat["sec"] = 0
        dms_lat["hem"] = "N"
        dms_lon["deg"] = 0
        dms_lon["min"] = 0
        dms_lon["sec"] = 0
        dms_lon["hem"] = "E"
    }

    $4 == "\"Canada\"" && $7 > 40 && $7 < 50 {
        gsub("\"","",$2)
        gsub("\"","",$6)
        dec_dms($7, $8)
        printf "%-5s %-5s %-4s %-4s %-5s %-4s %-4s \n", $6, dms_lat["deg"] "\xc2\xb0" dms_lat["hem"], dms_lat["min"] "\x27", dms_lat["sec"] "\x22", dms_lon["deg"] "\xc2\xb0" dms_lon["hem"], dms_lon["min"] "\x27", dms_lon["sec"] "\x22"
    }

    END {
        print "==============================================="
        print "End Of Report"
    }

