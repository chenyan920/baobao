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
function calculateDayToDay(year,mouth,day){
    var date = new Date()
    var date1 = new Date(2017,12,30)
    var dateString = date.toDateString()
    var date2 = new Date(dateString.slice(-4),dateString.slice(3,4),dateString.slice(6,8))
    return parseInt(((date2.getTime()-date1.getTime())/24/60/60/1000)+1)

}
