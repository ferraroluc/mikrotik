:local DATE [/system clock get date];
:local DAY [:pick $DATE 4 6];
:local YEAR [:pick $DATE 7 11];
:local MONTH [:pick $DATE 0 3];
:local spanishMONTH;

:local files {"Files/File1.txt";"Files/File2.txt"}

:if ($MONTH="jan") do={
    :set $spanishMONTH ("Enero");
};
:if ($MONTH="feb") do={
    :set $spanishMONTH ("Febrero");
};
:if ($MONTH="mar") do={
    :set $spanishMONTH ("Marzo");
};
:if ($MONTH="apr") do={
    :set $spanishMONTH ("Abril");
};
:if ($MONTH="may") do={
    :set $spanishMONTH ("Mayo");
};
:if ($MONTH="jun") do={
    :set $spanishMONTH ("Junio");
};
:if ($MONTH="jul") do={
    :set $spanishMONTH ("Julio");
};
:if ($MONTH="aug") do={
    :set $spanishMONTH ("Agosto");
};
:if ($MONTH="sep") do={
    :set $spanishMONTH ("Septiembre");
};
:if ($MONTH="oct") do={
    :set $spanishMONTH ("Octubre");
};
:if ($MONTH="nov") do={
    :set $spanishMONTH ("Noviembre");
};
:if ($MONTH="dec") do={
    :set $spanishMONTH ("Diciembre");
};

:if ($DAY="01") do={
    /tool e-mail send to="user@domain.com" subject="Cuota $spanishMONTH $YEAR" body="Estimados, buenos días.\n\n-Cuerpo del texto-\n\nGracias,\nSaludos." file="$files";
    :delay 30
    /file remove "Files/File1.txt";
    /file remove "Files/File2.txt";
};