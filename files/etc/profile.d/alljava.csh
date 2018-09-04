#
#    /etc/profile.d/alljava.csh
#
# send feedback to http://bugs.opensuse.org

#
# This script sets some environment variables for default java.
# Affected variables: JAVA_BINDIR, JAVA_HOME, JRE_HOME, 
#                     JDK_HOME, SDK_HOME
#

foreach JDIR ( "/usr/lib64/jvm" "/usr/lib/jvm" "/usr/java/latest" "/usr/java" )

    if ( ! -d $JDIR ) continue

    foreach JPATH ( $JDIR $JDIR/java $JDIR/java-[a-z]* $JDIR/java-[0-9]* $JDIR/jre $JDIR/jre-[a-z]* $JDIR/jre-[0-9]* )

	if ( ! -d $JPATH ) continue

        if ( ! -x $JPATH/bin/java ) continue

        setenv JAVA_BINDIR $JPATH/bin
        setenv JAVA_ROOT $JPATH
        setenv JAVA_HOME $JPATH
        unset JDK_HOME
        unset SDK_HOME

        switch ( $JPATH )
        case *jre*:
            setenv JRE_HOME $JPATH
            breaksw
        default:
            setenv JRE_HOME $JPATH/jre
            # it is development kit=20
            if ( -x $JPATH/bin/javac ) then
                setenv JDK_HOME $JPATH
                setenv SDK_HOME $JPATH
            endif
        endsw
    end
    unset JPATH
end
unset JDIR
