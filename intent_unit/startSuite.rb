$:.unshift File.dirname(__FILE__)
require './require/automationrequire'
passed = 0
failed = 0
passedAr = Array[]
failedAr = Array[]
# Cases to be run.  Would be better to have suites but time is currently limited
#cases = Array['Case01', 'Case02', 'Case03', 'Case04', 'Case05', 'Case06', 'Case07',
#						  'Case08', 'Case09', 'Case10', 'Case11', 'Case12', 'Case13', 'Case14',
#							'Case15', 'Case16', 'Case17', 'Case18', 'Case19', 'Case20', 'Case21',
#							'Case22', 'Case23', 'Case24', 'Case25', 'Case26']
cases = Array['Case01', 'Case10', 'Case11']

loggEr("**Test script execution started on #{Time.new.strftime("%Y-%m-%d %H:%M:%S")}.  Will attempt to run #{cases.length} test cases**\n")
#Loops array and checkes if the file exists, if not it will skip and report that the file is missing.
cases.each {
|x|
caseFile = "#{x}.rb"
if File.exists?("./cases/#{caseFile}")
	loggEr("=Running test #{caseFile}=")
	#system("ruby #{caseFile}")
	begin
	#load "./cases/#{caseFile}"
	system ("ruby ./cases/#{caseFile}")
	end
	if $?.exitstatus != 0
			loggEr("Error: Script #{caseFile} failed to complete successfully")
			failed += 1
			failedAr.push("#{caseFile}")
		else
			loggEr("Log: Script #{caseFile} was run successfully")
			passed += 1
			passedAr.push("#{caseFile}")
	end
	loggEr("=#{caseFile} is finished =")
	loggEr("")
else
	loggEr("Error: **#{caseFile} file does not exist, proceeding to next case**")
	puts
end
}
loggEr("**Summary**")
loggEr("**Test script execution has completed with #{failed} failed and #{passed} passed**")
loggEr("**Passed cases #{passedAr}**")
loggEr("**Failed cases #{failedAr}**")
