def jobName = "jobName"
def minNumber = 36
def maxNumber = 43

Jenkins.instance.getItemByFullName(jobName).builds.findAll {
    minNumber <= it.number && it.number <= maxNumber
}.each {
    it.delete()
}