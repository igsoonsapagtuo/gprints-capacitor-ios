import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.gratefulprints.app',
  appName: 'Grateful Prints',
  webDir: 'www',
  server: {
    url: 'https://app.gratefulprintsph.com',
    cleartext: false,
    allowNavigation: [
      'app.gratefulprintsph.com',
      // OAuth provider domains. Required so sign-in navigation is not blocked by
      // limitsNavigationsToAppBoundDomains. Derived from the live redirect chains
      // of /api/oauth/{apple,google,facebook}/*, not guessed.
      'appleid.apple.com',
      'accounts.google.com',
      'www.facebook.com',
      'm.facebook.com'
    ]
  },
  ios: {
    // The web app lays itself out under the status bar with
    // env(safe-area-inset-*), as it does as an installed web app. 'automatic'
    // made iOS inset the web view as well, so pages got the inset twice.
    contentInset: 'never',
    backgroundColor: '#1A3DB5',
    preferredContentMode: 'mobile',
    limitsNavigationsToAppBoundDomains: true,
    // GratefulPrintsIOSApp marks the app (checked as a substring, so it can be
    // followed by more markers). GPEdgeToEdge tells the web app this build
    // draws under the status bar, so it keeps older builds unchanged.
    appendUserAgent: 'GratefulPrintsIOSApp GPEdgeToEdge'
  }
};

export default config;
