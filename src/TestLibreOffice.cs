/*
 * This file is part of the LibreOffice project.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * This file incorporates work covered by the following license notice:
 *
 *   Licensed to the Apache Software Foundation (ASF) under one or more
 *   contributor license agreements. See the NOTICE file distributed
 *   with this work for additional information regarding copyright
 *   ownership. The ASF licenses this file to you under the Apache
 *   License, Version 2.0 (the "License"); you may not use this file
 *   except in compliance with the License. You may obtain a copy of
 *   the License at http://www.apache.org/licenses/LICENSE-2.0 .
 */

using System;
using System.Threading;

// __________  implementation  ____________________________________

/** Create and modify a spreadsheet view.
 */
public class TestLibreOffice : SpreadsheetDocHelper
{

    public static void Main( String [] args )
    {
        try
        {
            using ( TestLibreOffice aSample = new TestLibreOffice( args ) )
            {
                aSample.doSampleFunction();
                aSample.getDocument();
            }
            Console.WriteLine( "\nSamples done." );
        }
        catch (Exception ex)
        {
            Console.WriteLine( "Sample caught exception! " + ex );
        }
    }

    public TestLibreOffice( String[] args )
        : base( args )
    {
    }

    /** This sample function performs all changes on the view. */
    public void doSampleFunction()
    {
        unoidl.com.sun.star.sheet.XSpreadsheetDocument xDoc = getDocument();
        unoidl.com.sun.star.frame.XModel xModel =
            (unoidl.com.sun.star.frame.XModel) xDoc;
        unoidl.com.sun.star.frame.XController xController =
            xModel.getCurrentController();
 
        // --- Spreadsheet view ---
        // freeze the first column and first two rows
        unoidl.com.sun.star.sheet.XViewFreezable xFreeze =
            (unoidl.com.sun.star.sheet.XViewFreezable) xController;
        if ( null != xFreeze )
            Console.WriteLine( "got xFreeze" );
        xFreeze.freezeAtPosition( 1, 2 );
    }
}
