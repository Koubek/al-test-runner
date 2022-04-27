export const objectDeclarationRegEx: string = '(codeunit|table|report|page|query)(extension){0,1} \\d+ .*';
export const appInsightsKey = '2883f44a-b36e-4d64-833e-822eeb95d047';
export enum RunType { 'All', 'Codeunit', 'Test' };
export const failedToPublishMessage: string = 'The app failed to compile or failed to publish to the container within the publishing timeout (see settings).';