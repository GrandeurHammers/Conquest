let pointToLetter = ['A', 'B', 'C'];
let defaultLingerTime = 0.6;
let altLingerTime = 0.2;
var result = `
rule "Zone ${pointToLetter[point]}: Disable Flashing Colors when Zone Progress becomes 0":
    @Condition abs(zone${pointToLetter[point]}Progress) == 0
    wait(0.016)
    if not RULE_CONDITION:
        return
    altColorLoop[${point}] = false
    altColorControl[${point}] = false
    
rule "Zone ${pointToLetter[point]}: Enable/Disable Alt Color on Loop":
    @Condition altColorLoop[${point}]
    wait(${defaultLingerTime})
    if not RULE_CONDITION:
        return
    altColorControl[${point}] = true
    wait(${altLingerTime})
    if not RULE_CONDITION:
        return
    altColorControl[${point}] = false
    if RULE_CONDITION:
        goto RULE_START`;
console.log(result);
result;