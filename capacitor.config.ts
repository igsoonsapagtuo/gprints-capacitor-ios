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
    contentInset: 'automatic',
    backgroundColor: '#1A3DB5',
    preferredContentMode: 'mobile',
    limitsNavigationsToAppBoundDomains: true,
    appendUserAgent: 'GratefulPrintsIOSApp'
  }
};

export default config;
