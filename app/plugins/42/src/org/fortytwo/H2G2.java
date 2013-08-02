package org.fourtytwo;

import java.lang.String;
import java.lang.System;

public class H2G2 {

    public H2G2() {
    }

    public H2G2(String message) {
        System.out.println(message + " from H2G2");
    }

    public int theAnswerToLifeTheUniverseAndEverything() {
        return 42;
    }

    public String theAnswerToLifeTheUniverseAndEverything(String question) {
        return "Your question : " + question + "\n" + "The Answer is 42";
    }

}
