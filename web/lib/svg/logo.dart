import 'package:nekolib.ui/ui.dart';

const logoSVG = '''
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="268" height="268" viewBox="0 0 268 268">
  <defs>
    <filter id="Background" x="0" y="0" width="268" height="268" filterUnits="userSpaceOnUse">
      <feOffset dy="3" input="SourceAlpha"/>
      <feGaussianBlur stdDeviation="3" result="blur"/>
      <feFlood flood-opacity="0.161"/>
      <feComposite operator="in" in2="blur"/>
      <feComposite in="SourceGraphic"/>
    </filter>
    <filter id="Icon_awesome-book-open" x="36.727" y="56.343" width="193.605" height="154.585" filterUnits="userSpaceOnUse">
      <feOffset dy="3" input="SourceAlpha"/>
      <feGaussianBlur stdDeviation="3" result="blur-2"/>
      <feFlood flood-opacity="0.431"/>
      <feComposite operator="in" in2="blur-2"/>
      <feComposite in="SourceGraphic"/>
    </filter>
  </defs>
  <g id="Content" transform="translate(9.219 6.219)">
    <g transform="matrix(1, 0, 0, 1, -9.22, -6.22)" filter="url(#Background)">
      <rect id="Background-2" data-name="Background" width="250" height="250" rx="24" transform="translate(9 6)" fill="${NcVectorImage.primaryColor}"/>
    </g>
    <g transform="matrix(1, 0, 0, 1, -9.22, -6.22)" filter="url(#Icon_awesome-book-open)">
      <path id="Icon_awesome-book-open-2" data-name="Icon awesome-book-open" d="M165.309,2.266C148.6,3.214,115.4,6.666,94.9,19.214a4.687,4.687,0,0,0-2.216,4.015V134.164a4.825,4.825,0,0,0,7.1,4.113c21.091-10.616,51.594-13.512,66.676-14.3a9.509,9.509,0,0,0,9.152-9.347v-103a9.558,9.558,0,0,0-10.3-9.36ZM80.71,19.214c-20.5-12.549-53.7-16-70.411-16.948A9.562,9.562,0,0,0,0,11.626v103a9.5,9.5,0,0,0,9.152,9.347c15.088.793,45.606,3.692,66.7,14.314a4.81,4.81,0,0,0,7.076-4.1V23.175A4.59,4.59,0,0,0,80.71,19.214Z" transform="translate(45.73 60.09)" fill="${NcVectorImage.accentColor}"/>
    </g>
  </g>
</svg>

''';
