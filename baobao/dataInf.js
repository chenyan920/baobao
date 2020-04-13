function getSecond() {
    var data = new Date()
    return data.getSeconds()
}
function getDay() {
    var data = new Date()
    return data.getDay()
}
function getLoctateTime(){
    var date = new Date()
    return date.toLocaleTimeString()
}
function calculateDayToDay(){
    var date = new Date
    var date1 = new Date(2017,12,30)
    var date2 = new Date(date.getFullYear(),date.getMonth()+1,date.getDate())
    return parseInt(((date2.getTime()-date1.getTime())/24/60/60/1000)+2)
}
