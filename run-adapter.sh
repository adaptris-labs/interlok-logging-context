INTERLOK_INSTALL_DIR="./build/distribution"

# Since gradle assemble always destroys the ui-resources directory
# may as well use an in memory DB

mkdir -p $INTERLOK_INSTALL_DIR/ui-resources
cat > $INTERLOK_INSTALL_DIR/ui-resources/interlokuidb.properties<<EOL
dataSource.provider=derby
dataSource.driverClass=org.apache.derby.jdbc.EmbeddedDriver
dataSource.jdbcURL=jdbc:derby:memory:interlokuidb;create=true
dataSource.user=interlokuidb
dataSource.password=interlokuidb
EOL

JAVA_ARGS="-javaagent:./lib/aspectjweaver.jar -Dorg.aspectj.weaver.loadtime.configuration=META-INF/profiler-logging-context.xml"
(cd $INTERLOK_INSTALL_DIR && java $JAVA_ARGS -jar lib/interlok-boot.jar)
