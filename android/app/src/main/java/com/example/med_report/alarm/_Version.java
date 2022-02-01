package com.example.med_report.alarm;

public interface _Version {

    void from_v16();
    void from_v26(); // O
    void from_v29(); // Q

    /*
     *
     */
    default void initImpl() {
        from_v16();
        from_v26();
        from_v29();
    }

    /*
     *
     */

}
