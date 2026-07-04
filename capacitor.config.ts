import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.gratefulprintsph.app',
  appName: 'Grateful Prints',
  webDir: 'www',
  server: {
    url: 'https://app.gratefulprintsph.com',
    cleartext: false,
    allowNavigation: ['app.gratefulprintsph.com']
  },
  ios: {
    contentInset: 'automatic',
    backgroundColor: '#1A3DB5',
    preferredContentMode: 'mobile',
    limitsNavigationsToAppBoundDomains: true
  }
};

export default config;
