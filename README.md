# miniprojeto05 - lugares

To run the app, first add your google api key to the AndroidManifest.xml:
<meta-data 
            android:name="com.google.android.geo.API_KEY"
            android:value="Your api key" />
Change the minsdkversion to 20 in build.gradle.

Then, create a file called .env in the same folder as lib and add those lines:

GOOGLE_API_KEY = 'Your API key'
FIREBASE_URL = 'your database url'

