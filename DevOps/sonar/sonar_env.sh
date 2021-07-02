if [ "$use_sonar" = "1" ]; then
  jacoco_pre=org.jacoco:jacoco-maven-plugin:prepare-agent
  jacoco_report=org.jacoco:jacoco-maven-plugin:report
  with_jacoco="$jacoco_pre $maven_goals $jacoco_report"
  sonar=org.sonarsource.scanner.maven:sonar-maven-plugin:sonar
  sonar_key="-D sonar.projectKey=${projectKey}"
  sonar_name="-D sonar.projectName=${projectName}"
  sonar_url="-D sonar.host.url=${全局变量}"
  sonar_login="-D sonar.login=${全局变量}"
  sonar_param="$sonar_key $sonar_name $sonar_url $sonar_login"
  maven_goals="$with_jacoco $sonar $sonar_param"
  echo "maven_goals=$maven_goals" >> /data/easyops/.pipeline_env_var
fi