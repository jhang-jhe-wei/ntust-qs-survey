// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from 'stimulus';
import { definitions } from 'stimulus:stimulus/controllers';

import './jquery-setup';
import 'jquery-ui-bundle';

const app = Application.start();
app.load(definitions);
