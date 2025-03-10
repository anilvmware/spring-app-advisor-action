#EMAIL="anil-an.nair@bradcom.com"
#ARTIFACTORY_TOKEN="eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJNUmo4OWVRNjkwSEE3eE40cXZvZ0FnajczSFJhdDNKcWcxanYyNDZHdTRnIn0.eyJzdWIiOiJqZnJ0QDAxZXA4M3F2MzFjcnowMHg2ZjZ6eWYwNHo2L3VzZXJzL2FuaWwtYW4ubmFpckBicm9hZGNvbS5jb20iLCJzY3AiOiJtZW1iZXItb2YtZ3JvdXBzOlROWi1TUFJJTkciLCJhdWQiOiJqZnJ0QDAxZXA4M3F2MzFjcnowMHg2ZjZ6eWYwNHo2IiwiaXNzIjoiamZydEAwMWVwODNxdjMxY3J6MDB4NmY2enlmMDR6Ni91c2Vycy9jc3AtdG9rZW4tZ3JhbnRvciIsImV4cCI6MTc1NDIzNjgxOCwiaWF0IjoxNzM4NTk4NDE4LCJqdGkiOiIyNTI3NjNlOS0zNGJjLTQ0MmUtYjUyMS03NWQ3MTFjNzRmMzEifQ.Vpzm6o56vd9STCdyo84Nj-XHQbGH2Sy6hKjtKRBsBxqX0LfAe84Mpe3yPLw-XaLtcxE8qZkK5LdfJerPRO8-3cs5kixq1EpAccLk0PlQ7KojTPiaS8anVwdwfBVAXUVAS78jBhUQgX72G6rkTxx-4TTjKbG2KqgzI28o8hdopyjFWgQlx8f15J_kQfP5kQXXKov8_slwxpS4ryBA7bLDSbQ2sjJos70118TPtI8n4g-W3pJ0ofxKrDqanSVa0TdHDUzfsJYnpS2rsuhLcbruYWPhhD4K8XNUz_6Kq8bjWDDT6Aw1CMMDeX3dsQ--SX1fyiKE2JJrd6Ed1Ax6TlEWPQ"
echo "<settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
  xsi:schemaLocation=\"http://maven.apache.org/SETTINGS/1.0.0 https://maven.apache.org/xsd/settings-1.0.0.xsd\">
  <servers>
    <server>
      <id>spring-enterprise-subscription</id>
      <username>$EMAIL</username>
      <password>$ARTIFACTORY_TOKEN</password>
    </server>
  </servers>
  <profiles>
    <profile>
      <id>spring-enterprise</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <repositories>
        <repository>
          <id>spring-enterprise-subscription</id>
          <url>https://packages.broadcom.com/artifactory/spring-enterprise</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <id>spring-enterprise-subscription</id>
          <url>https://packages.broadcom.com/artifactory/spring-enterprise</url>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
  <activeProfiles>
   <activeProfile>spring-enterprise</activeProfile>
  </activeProfiles>
</settings>" > $HOME/.m2/settings.xml

mkdir -p $HOME/.gradle/init.d/

echo "apply plugin: SpringEnterpriseRepositoryPlugin

class SpringEnterpriseRepositoryPlugin implements Plugin<Gradle> {

    void apply(Gradle gradle) {
        gradle.allprojects { project ->
            project.repositories {
                // add the Spring enterprise repository
                maven {
                    name \"SPRING_ENTERPRISE_REPO\"
                    url \"https://packages.broadcom.com/artifactory/spring-enterprise\"

                    credentials {
                      username \"$EMAIL\"
                      password \"$ARTIFACTORY_TOKEN\"
                    }
                    authentication {
                      basic(BasicAuthentication)
                    }
                }
            }
        }
    }
}" > $HOME/.gradle/init.d/init.gradle
