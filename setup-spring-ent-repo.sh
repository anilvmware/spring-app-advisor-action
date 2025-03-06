# EMAIL='email@email.com'
# ARTIFACTORY_TOKEN='asdf'
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
