def bin_to_dec(bin):
    result = 0
    power = 2**len(bin)
    
    for i in bin:
        power = power / 2
        if i == "1":
            result += power
    return result

print bin_to_dec("101")